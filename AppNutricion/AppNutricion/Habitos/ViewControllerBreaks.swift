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
    
    var hora = "00:00"
    //var listaBreaks = [Breaks(tiempo: "00 : 00 : 00", hora: "00:00")]
    //Variables para picker views
    var pickerCantidad = UIPickerView()
    let cantidad = ["1","2","3","4"]
    var pickerDuracion = UIPickerView()
    let duracion = ["5","10","15","20"]
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
    var contHr = 1.0
    var contMin = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Para el tf de cantidad de breaks
        pickerCantidad.tag = 0
        self.pickerCantidad.delegate = self
        self.pickerCantidad.dataSource = self
        tfCantidad.inputView = pickerCantidad
        tfCantidad.textAlignment = .center
        tfCantidad.textColor = .link
        //FIN tfCantidad
        
        //Para el tf de cada cuanto tiempo deben durar los breaks
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        tfCadaCuanto.text = formatter.string(from: time)
        tfCadaCuanto.textColor = .link
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .countDownTimer
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 250)
        
        timePicker.preferredDatePickerStyle = .wheels
        
        tfCadaCuanto.inputView = timePicker
        //FIN tfCadaCuanto
        
        //Para el tf de duracion de cada break
        pickerDuracion.tag = 1
        self.pickerDuracion.delegate = self
        self.pickerDuracion.dataSource = self
        tfDuracion.inputView = pickerDuracion
        tfDuracion.textAlignment = .center
        tfDuracion.textColor = .link
        //FIN tfDuracion
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewControllerBreaks.viewTapped(gestureRecognizer: )))
        view.addGestureRecognizer(tapGesture)
        
        btnGuardar.layer.cornerRadius = 6
        
       /* let app = UIApplication.shared
                
                NotificationCenter.default.addObserver(self, selector: #selector(guardarDatos), name: UIApplication.didEnterBackgroundNotification, object: app)
                
                if FileManager.default.fileExists(atPath: dataFileURL().path){
                    obtenerDatos()
                }
                
                actualiza()
        */
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
    }
    
    // Para que no se adapte al tamaño de diferentes pantallas
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
    
/*
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
        let t = listaBreaks[0].tiempo
        
        let hr = listaBreaks[0].hora
        tfCadaCuanto.text = hr
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
*/
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
        for i in 2...strCant {
            //RECORDATORIO DE TERMINACION DE BREAK
            //Dura timeNoti + duracion de cada break
            let content2 = UNMutableNotificationContent()
            content2.title = "Recordatorio"
            content2.subtitle = "Breaks de actividades"
            content2.body = "Break finalizado"
            content2.badge = 1
            
            strCadaCuanto2 = tfCadaCuanto.text
            strDuracion = tfDuracion.text
            let mySubstringHr2 = strCadaCuanto2.prefix(2)
            let mySubstringM2 = strCadaCuanto2.suffix(2)
            doubleHr2 = (Double(mySubstringHr2)! * 3600) * contHr
            doubleMin2 = (Double(mySubstringM2)! * 60) * contHr
            doubleDuracion = (Double(strDuracion)! * 60) * contMin
            timeNoti2 = doubleHr2 + doubleMin2 + doubleDuracion//sumar duracion
            
            let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: timeNoti2, repeats: false)
            let request2 = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger2)
            
            UNUserNotificationCenter.current().add(request2, withCompletionHandler: nil)
            //FIN RECORDATORIO
            
            contHr += 1
            let content = UNMutableNotificationContent()
            content.title = "Recordatorio"
            content.subtitle = "Breaks de actividades"
            content.body = "Tomate un break :) Te avisamos cuando haya finalizado"
            content.badge = 1
            
            strCadaCuanto = tfCadaCuanto.text
            strDuracion = tfDuracion.text
            let mySubstringHr = strCadaCuanto.prefix(2)
            let mySubstringM = strCadaCuanto.suffix(2)
            doubleHr = (Double(mySubstringHr)! * 3600) * contHr
            doubleMin = (Double(mySubstringM)! * 60) * contHr
            doubleDuracion2 = (Double(strDuracion)! * 60) * contMin
            timeNoti = doubleHr + doubleMin + doubleDuracion//Cada cuanto va a suceder
            contMin += 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeNoti, repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        //FIN FOR LOOP
        
        //RECORDATORIO DE TERMINACION DE BREAK FINAL
        let content2 = UNMutableNotificationContent()
        content2.title = "Recordatorio"
        content2.subtitle = "Breaks de actividades"
        content2.body = "Break finalizado"
        content2.badge = 1
        
        strCadaCuanto2 = tfCadaCuanto.text
        strDuracion = tfDuracion.text
        let mySubstringHr2 = strCadaCuanto2.prefix(2)
        let mySubstringM2 = strCadaCuanto2.suffix(2)
        doubleHr2 = (Double(mySubstringHr2)! * 3600) * contHr
        doubleMin2 = (Double(mySubstringM2)! * 60) * contHr
        doubleDuracion = (Double(strDuracion)! * 60) * contMin
        timeNoti2 = doubleHr2 + doubleMin2 + doubleDuracion//sumar duracion
        
        let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: timeNoti2, repeats: false)
        let request2 = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger2)
        
        UNUserNotificationCenter.current().add(request2, withCompletionHandler: nil)
        //FIN RECORDATORIO FINAL
        
        /*
        hora = tfCadaCuanto.text!
        listaBreaks = [Breaks(tiempo: t,hora: hora)]
        guardarDatos()
        */
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
        vistaPopOver.texto = "Esto es un texto de prueba sobre el beneficio de breaks de actividades"
    }
}
