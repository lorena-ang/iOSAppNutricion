//
//  ViewControllerCelular.swift
//  AppNutricion
//
//  Created by Estefy Charles on 30/10/21.
//

import UIKit

class ViewControllerCelular: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var lbHrsSinCel: UILabel!
    @IBOutlet weak var tfHrDormir: UITextField!
    @IBOutlet weak var btnGuardar: UIButton!
    
    var hora = "00:00"
    var hrsSinCel = 0
    var listaCelular = [Celular]()
    var str : String!
    var doubleMin : Double!
    var doubleHr : Double!
    var timeNoti : Double!
    var horaNoti : Int!
    var minNoti : Int!
    var horaCel : Int!
    var strCel : String!
    var fechaActual = DateComponents()
    var components = DateComponents()
    var id = 2
    var completado = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbHrsSinCel.clipsToBounds = true
        lbHrsSinCel.layer.cornerRadius = 6
        lbHrsSinCel.layer.borderWidth = 0.4
        lbHrsSinCel.layer.borderColor = UIColor.lightGray.cgColor
        btnGuardar.layer.cornerRadius = 6
        
        //Inicializa el arreglo con la fecha actual
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        components.day = day
        components.month = month
        components.year = year
        listaCelular.append(Celular(id: id, hora: hora, hrsSin: hrsSinCel, completado: completado, fecha: .init(year:year, month:month, day:day)))
       ///
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        tfHrDormir.text = formatter.string(from: time)
        //tfHrDormir.textColor = .link
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 250)
        
        timePicker.preferredDatePickerStyle = .wheels
        
        tfHrDormir.inputView = timePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewControllerSuen_o.viewTapped(gestureRecognizer: )))
        view.addGestureRecognizer(tapGesture)
        
        let app = UIApplication.shared
                
        NotificationCenter.default.addObserver(self, selector: #selector(guardarDatos), name: UIApplication.didEnterBackgroundNotification, object: app)
                
        if FileManager.default.fileExists(atPath: dataFileURL().path){
            obtenerDatos()
        }
                
        actualiza()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func timePickerValueChanged(sender:UIDatePicker){
        //cuando el tiempo se cambia, va aparecer aqui
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        tfHrDormir.text = formatter.string(from: sender.date)
    }
    
    @IBAction func btnMasHoras(_ sender: UIButton) {
        guard let actual = Int(lbHrsSinCel.text!) else {return}
        let nuevo = actual + 1
        lbHrsSinCel!.text = String(nuevo)
    }
    
    @IBAction func btnMenosHoras(_ sender: UIButton) {
        guard let actual = Int(lbHrsSinCel.text!) else {return}
        if actual != 0 && actual > 0{
            let nuevo = actual - 1
            lbHrsSinCel!.text = String(nuevo)
        }
    }
    
    func dataFileURL() -> URL {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let pathArchivo = documentsDirectory.appendingPathComponent("Celular").appendingPathExtension("plist")
            //print(pathArchivo.path)
            return pathArchivo
    }
        
        @IBAction func guardarDatos(){
            do{
                let data = try PropertyListEncoder().encode(listaCelular)
                try data.write(to: dataFileURL())
            }
            catch{
                print("Error al guardar los datos")
            }
        }
        
        func actualiza(){
            //Obtiene fecha actual
            let date = Date()
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            fechaActual.day = day
            fechaActual.month = month
            fechaActual.year = year
            
            if  fechaActual.day != listaCelular[0].fecha.day || fechaActual.month != listaCelular[0].fecha.month{
                
                tfHrDormir.text = ""
                lbHrsSinCel.text = ""
                
                let nuevoCelular = Celular(id: id, hora: "0", hrsSin: 0, completado: completado, fecha: .init(year:fechaActual.year, month: fechaActual.month, day: fechaActual.day))
                listaCelular.insert(nuevoCelular, at: 0)
            }
            else{
                let hr = listaCelular[0].hora
                tfHrDormir.text =  String(hr!)
                let hsc = listaCelular[0].hrsSin
                lbHrsSinCel.text =  String(hsc!)
            }
        }
        
    @IBAction func obtenerDatos() {
        listaCelular.removeAll()
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            listaCelular = try PropertyListDecoder().decode([Celular].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
    }
    
    @IBAction func btGuardarA(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "Recordatorio"
        content.subtitle = "Horas antes de dormir sin celular"
        content.body = "Es hora de dejar el cel :)"
        content.badge = 1
        
        //SACA FECHA
        let date = Date()
        let formatter = DateFormatter()
        let year = formatter.string(from: date)
        let month = formatter.string(from: date)
        let day = formatter.string(from: date)
        
        //SACA HORA
        str = tfHrDormir.text
        strCel = lbHrsSinCel.text
        let mySubstringHr = str.prefix(2)
        let mySubstringM = str.suffix(2)
        //timeNoti = doubleHr + doubleMin
        horaNoti = Int(mySubstringHr)! - Int(strCel)!
        minNoti = Int(mySubstringM)!
        
        //FECHA PARA NOTIFICACION
        var dateInfo = DateComponents()
            dateInfo.day = Int(day)
            dateInfo.month = Int(month)
            dateInfo.year = Int(year)
            dateInfo.hour = horaNoti
            dateInfo.minute = minNoti
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        let dateA = Date()
        let calendar = Calendar.current
        let dayA = calendar.component(.day, from: dateA)
        let monthA = calendar.component(.month, from: dateA)
        let yearA = calendar.component(.year, from: dateA)
        components.day = dayA
        components.month = monthA
        components.year = yearA
        
        //GUARDA LA INFO EN EL ARREGLO
        hora = tfHrDormir.text!
        hrsSinCel = Int(lbHrsSinCel.text!)!
        completado = true
        
        listaCelular[0].id = id
        listaCelular[0].hora = hora
        listaCelular[0].hrsSin = hrsSinCel
        listaCelular[0].completado = completado
        listaCelular[0].fecha = components
        
        guardarDatos()
        dismiss(animated: true, completion: nil)
    }
    
    // Para que no se adapte al tamaño de diferentes pantallas
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guardarDatos()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vistaPopOver = segue.destination as! ViewControllerPopOver
        vistaPopOver.popoverPresentationController?.delegate = self
        vistaPopOver.texto = "Los aparatos como celular, tablets y demás interfieren no solo con la cantidad pero la calidad de nuestro sueño. ¡Comienza dejando el celular media hora antes de dormir!"
    }
    
    // MARK: - Limitar orientación a portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
