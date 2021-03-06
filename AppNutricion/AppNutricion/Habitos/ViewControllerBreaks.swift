//
//  ViewControllerBreaks.swift
//  AppNutricion
//
//  Created by Lore Ang on 01/11/21.
//

import UIKit

class ViewControllerBreaks: UIViewController, UIPopoverPresentationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tfCantidad: UITextField!
    @IBOutlet weak var tfCadaCuanto: UITextField!
    @IBOutlet weak var tfDuracion: UITextField!
    @IBOutlet weak var btnGuardar: UIButton!
    
    var listaBreaks = [Breaks]()
    var id = 4
    //Variables para picker views
    var pickerCantidad = UIPickerView()
    let cantidad = ["1","2","3","4"]
    var pickerDuracion = UIPickerView()
    let duracion = ["1","10","15","20"]
    //Variables para recordatorios
    var strCant : Int!
    var strCadaCuanto : String!
    var strCadaCuanto2 : String!
    var strDuracion : String!
    var doubleDuracion : Double!
    var doubleDuracion2 : Double!
    var doubleMin : Double!
    var doubleMin2 : Double!
    var doubleHr : Double!
    var doubleHr2 : Double!
    var timeNoti : Double!
    var timeNoti2 : Double!
    var timeNoti3 : Double!
    var contHr = 1.0
    var contMin = 1.0
    var conNotiI = 200
    var conNotiF = 100
    var fechaActual = DateComponents()
    var components = DateComponents()
    var cant : String!
    var dur : String!
    var cadaCuanto : String!
    var completado = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        components.day = day
        components.month = month
        components.year = year
        listaBreaks.append(Breaks(id: id, cantidad: "0", cadaCuanto: "00:00", duracion: "0", completado: completado, fecha: .init(year:year, month: month, day: day)))
        
        //Para el tf de cantidad de breaks
        pickerCantidad.tag = 0
        self.pickerCantidad.delegate = self
        self.pickerCantidad.dataSource = self
        tfCantidad.inputView = pickerCantidad
        tfCantidad.textAlignment = .center
        //tfCantidad.textColor = .link
        //FIN tfCantidad
        
        //Para el tf de cada cuanto tiempo deben durar los breaks
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        //tfCadaCuanto.text = formatter.string(from: time)
        //tfCadaCuanto.textColor = .link
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .countDownTimer
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 250)
        
        timePicker.preferredDatePickerStyle = .wheels
        
        tfCadaCuanto.inputView = timePicker
        
        tfCadaCuanto.resignFirstResponder()
        //FIN tfCadaCuanto
        
        //Para el tf de duracion de cada break
        pickerDuracion.tag = 1
        self.pickerDuracion.delegate = self
        self.pickerDuracion.dataSource = self
        tfDuracion.inputView = pickerDuracion
        tfDuracion.textAlignment = .center
        //tfDuracion.textColor = .link
        //FIN tfDuracion
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewControllerBreaks.viewTapped(gestureRecognizer: )))
        view.addGestureRecognizer(tapGesture)
        
        btnGuardar.layer.cornerRadius = 6
        
       let app = UIApplication.shared
                
                NotificationCenter.default.addObserver(self, selector: #selector(guardarDatos), name: UIApplication.didEnterBackgroundNotification, object: app)
                
                if FileManager.default.fileExists(atPath: dataFileURL().path){
                    obtenerDatos()
                }
                
                actualiza()
    
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
    }
    
    // Para que no se adapte al tama??o de diferentes pantallas
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func timePickerValueChanged(sender:UIDatePicker){
        //cuando el tiempo se cambia, va aparecer aqui
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        tfCadaCuanto.text = formatter.string(from: sender.date)
    }
    
    func dataFileURL() -> URL {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let pathArchivo = documentsDirectory.appendingPathComponent("Breaks").appendingPathExtension("plist")
            //print(pathArchivo.path)
            return pathArchivo
        }

        @IBAction func guardarDatos(){
            do{
                let data = try PropertyListEncoder().encode(listaBreaks)
                try data.write(to: dataFileURL())
            }
            catch{
                print("Error al guardar los datos")
            }
        }
    
    func actualiza(){
        //let t = listaMeditacion.first?.tiempo
        //lbCronometro.text = t
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        fechaActual.day = day
        fechaActual.month = month
        fechaActual.year = year
        
        if  fechaActual.day != listaBreaks[0].fecha.day || fechaActual.month != listaBreaks[0].fecha.month{
            
            tfCantidad.text = "0"
            tfCadaCuanto.text = "00:00"
            tfDuracion.text = "0"
            
            let nuevosBreaks = Breaks(id: id, cantidad: "0", cadaCuanto: "00:00", duracion: "0", completado: completado, fecha: .init(year:fechaActual.year, month: fechaActual.month, day: fechaActual.day))
            listaBreaks.insert(nuevosBreaks, at: 0)
        
        }else{
            let cant = listaBreaks[0].cantidad
            tfCantidad.text = cant
            
            let cc = listaBreaks[0].cadaCuanto
            tfCadaCuanto.text = cc
            
            let d = listaBreaks[0].duracion
            tfDuracion.text = d
        }
    }
    
    @IBAction func obtenerDatos() {
        listaBreaks.removeAll()
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            listaBreaks = try PropertyListDecoder().decode([Breaks].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
    }
 
    @IBAction func btnGuardarA(_ sender: Any) {
        //Al dar click los recordatorios se activan
        //RECORDATORIO DE BREAK 1
        let content = UNMutableNotificationContent()
        content.title = "Recordatorio"
        content.subtitle = "Breaks de actividades"
        content.body = "Tomate un break :) Te avisamos cuando haya finalizado"
        content.badge = 1
        
        strCadaCuanto = tfCadaCuanto.text
        let mySubstringHr = strCadaCuanto.prefix(2)
        let mySubstringM = strCadaCuanto.suffix(2)
        doubleHr = Double(mySubstringHr)! * 3600
        doubleMin = Double(mySubstringM)! * 60
        timeNoti = doubleHr + doubleMin //Cada cuanto va a suceder
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeNoti, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        //FIN RECORDATORIO 1
        
        //FOR LOOP
        strCant = Int(tfCantidad.text!)
        if strCant > 1 {
            for i in 2...strCant {
                //RECORDATORIO DE TERMINACION DE BREAK
                //Dura timeNoti + duracion de cada break
                let content2 = UNMutableNotificationContent()
                content2.title = "Recordatorio"
                content2.subtitle = "Breaks de actividades"
                content2.body = "Break finalizado"
                content2.badge = 1
                
                //strCadaCuanto2 = tfCadaCuanto.text
                strDuracion = tfDuracion.text
                /*
                let mySubstringHr2 = strCadaCuanto2.prefix(2)
                let mySubstringM2 = strCadaCuanto2.suffix(2)
                 */
                doubleHr = (Double(mySubstringHr)! * 3600) * contHr
                doubleMin = (Double(mySubstringM)! * 60) * contHr
                doubleDuracion = (Double(strDuracion)! * 60) * contMin
                timeNoti2 = doubleHr + doubleMin + doubleDuracion//sumar duracion
                
                let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: timeNoti2, repeats: false)
                let request2 = UNNotificationRequest(identifier: "timerDone" + String(conNotiF), content: content2, trigger: trigger2)
                
                UNUserNotificationCenter.current().add(request2, withCompletionHandler: nil)
                //FIN RECORDATORIO
                conNotiF += 1
                contHr += 1
                let content = UNMutableNotificationContent()
                content.title = "Recordatorio"
                content.subtitle = "Breaks de actividades"
                content.body = "Tomate un break :) Te avisamos cuando haya finalizado"
                content.badge = 1
                
                /*strCadaCuanto = tfCadaCuanto.text
                strDuracion = tfDuracion.text
                let mySubstringHr = strCadaCuanto.prefix(2)
                let mySubstringM = strCadaCuanto.suffix(2)
                 */
                doubleHr = (Double(mySubstringHr)! * 3600) * contHr
                doubleMin = (Double(mySubstringM)! * 60) * contHr
                doubleDuracion = (Double(strDuracion)! * 60) * contMin
                timeNoti3 = doubleHr + doubleMin + doubleDuracion//Cada cuanto va a suceder
                contMin += 1
                
                let trigger3 = UNTimeIntervalNotificationTrigger(timeInterval: timeNoti3, repeats: false)
                let request3 = UNNotificationRequest(identifier: "timerDone" + String(conNotiI), content: content, trigger: trigger3)
                
                UNUserNotificationCenter.current().add(request3, withCompletionHandler: nil)
                
                conNotiI += 1
            }
            //FIN FOR LOOP
        }
    
        //RECORDATORIO DE TERMINACION DE BREAK FINAL
        let content2 = UNMutableNotificationContent()
        content2.title = "Recordatorio"
        content2.subtitle = "Breaks de actividades"
        content2.body = "Break finalizado"
        content.categoryIdentifier = "myCategory"
        content2.badge = 1
        
        strCadaCuanto2 = tfCadaCuanto.text
        strDuracion = tfDuracion.text
        let mySubstringHr2 = strCadaCuanto2.prefix(2)
        let mySubstringM2 = strCadaCuanto2.suffix(2)
        doubleHr2 = (Double(mySubstringHr2)! * 3600) * contHr
        doubleMin2 = (Double(mySubstringM2)! * 60) * contHr
        doubleDuracion = (Double(strDuracion)! * 60) * contMin
        timeNoti2 = doubleHr2 + doubleMin2 + doubleDuracion//sumar duracion
        
        let trigger4 = UNTimeIntervalNotificationTrigger(timeInterval: timeNoti2, repeats: false)
        let request4 = UNNotificationRequest(identifier: "timerDoneFinal", content: content2, trigger: trigger4)
        
        UNUserNotificationCenter.current().add(request4, withCompletionHandler: nil)
        //FIN RECORDATORIO FINAL
            
        cant = tfCantidad.text
        dur = tfDuracion.text
        cadaCuanto = tfCadaCuanto.text
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        components.day = day
        components.month = month
        components.year = year
        
        listaBreaks[0].id = id
        listaBreaks[0].cantidad = cant
        listaBreaks[0].cadaCuanto = cadaCuanto
        listaBreaks[0].duracion = dur
        listaBreaks[0].completado = true
        listaBreaks[0].fecha = components
        
        guardarDatos()
        
        dismiss(animated: true, completion: nil)
    }
   
    // MARK: - PickerViews
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerCantidad {
            return cantidad.count
        } else if pickerView == pickerDuracion  {
            return duracion.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?  {
        if pickerView == pickerCantidad {
            return cantidad[row]
        } else if pickerView == pickerDuracion{
            return duracion[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerCantidad {
            tfCantidad.text = cantidad[row]
            tfCantidad.resignFirstResponder()
        } else if pickerView == pickerDuracion {
            tfDuracion.text = duracion[row]
            tfDuracion.resignFirstResponder()
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vistaPopOver = segue.destination as! ViewControllerPopOver
        vistaPopOver.popoverPresentationController?.delegate = self
        vistaPopOver.texto = "Incorpora 4 breaks durante tu horario acad??mico/laboral, pueden ser desde 5-20 minutos. Aprovecha y lev??ntate, camina, activa tus m??sculos y evita el sedentarismo."
    }
    
    // MARK: - Limitar orientaci??n a portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
