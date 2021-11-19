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
    var listaCelular = [Celular(id: 2, hora: "00:00", hrsSin: 0)]
    var str : String!
    var doubleMin : Double!
    var doubleHr : Double!
    var timeNoti : Double!
    var horaNoti : Int!
    var minNoti : Int!
    var horaCel : Int!
    var strCel : String!
    var id = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbHrsSinCel.clipsToBounds = true
        lbHrsSinCel.layer.cornerRadius = 6
        lbHrsSinCel.layer.borderWidth = 0.4
        lbHrsSinCel.layer.borderColor = UIColor.lightGray.cgColor
        btnGuardar.layer.cornerRadius = 6
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        tfHrDormir.text = formatter.string(from: time)
        tfHrDormir.textColor = .link
        
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
            let hr = listaCelular[0].hora
            tfHrDormir.text =  String(hr!)
            let hsc = listaCelular[0].hrsSin
            lbHrsSinCel.text =  String(hsc!)
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
        hora = tfHrDormir.text!
        hrsSinCel = Int(lbHrsSinCel.text!)!
        listaCelular = [Celular(id: id, hora: hora, hrsSin: hrsSinCel)]
        guardarDatos()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRecordatorio(_ sender: UIButton) {
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
    }
    
    
    // Para que no se adapte al tamaño de diferentes pantallas
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vistaPopOver = segue.destination as! ViewControllerPopOver
        vistaPopOver.popoverPresentationController?.delegate = self
        vistaPopOver.texto = "Los aparatos como celular, tablets y demás interfieren no solo con la cantidad pero la calidad de nuestro sueño. ¡Comienza dejando el celular media hora antes de dormir!"
    }
}
