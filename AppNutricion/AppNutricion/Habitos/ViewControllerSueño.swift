//
//  ViewControllerSueño.swift
//  AppNutricion
//
//  Created by Chut on 29/10/21.
//

import UIKit

class ViewControllerSuen_o: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tfSueno: UITextField!
    @IBOutlet weak var btnGuardar: UIButton!
    @IBOutlet weak var lbDespertar: UILabel!
    
    var listaSueno = [Sueno(hora: "00:00")]
    var hora = "00:00"
    var str : String!
    var str2 : String!
    var enteros : Int!
    var enteros2 : Int!
    var enterosMin : Int!
    var enterosMin2: Int!
    var h : String!
    var h2 : String!
    var m : String!
    var m2 : String!
    var horaNoti : Int!
    var minNoti : Int!
    var strNoti : String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        tfSueno.text = formatter.string(from: time)
        tfSueno.textColor = .link
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 250)
        
        timePicker.preferredDatePickerStyle = .wheels
        
        tfSueno.inputView = timePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewControllerSuen_o.viewTapped(gestureRecognizer: )))
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
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func timePickerValueChanged(sender:UIDatePicker){
        //cuando el tiempo se cambia, va aparecer aqui
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        tfSueno.text = formatter.string(from: sender.date)
        str = tfSueno.text
        let mySubstring = str.prefix(2)
        let mySubstringM = str.suffix(2)
        enteros = Int(mySubstring)
        enterosMin = Int(mySubstringM)
        enteros = enteros - 8
        if enteros == 0 { //despertar 8am
            m = String(enterosMin)
            if enterosMin < 10 {
                lbDespertar.text = "00:0" + m + " AM"
            }else{
                lbDespertar.text = "00:" + m + " AM"
            }
        }
        else if enteros < 0{//despertar a las 12am o después y antes de las 8am
            enteros = 24 + enteros
            h = String(enteros)
            m = String(enterosMin)
            if enterosMin < 10 {
                lbDespertar.text =  h + ":0" + m + " PM"
            }else{
                lbDespertar.text =  h + ":" + m + " PM"
            }
        }
        else if enteros > 0 && enteros < 12{//despertar después de las 8am y antes de las 8pm
            h = String(enteros)
            m = String(enterosMin)
            if enterosMin < 10 && enteros < 10{
                lbDespertar.text = "0" + h + ":0" + m + " AM"
            }else if enterosMin >= 10 && enteros < 10{
                lbDespertar.text = "0" + h + ":" + m + " AM"
            }else if enterosMin < 10 && enteros >= 10{ //despertar a las 6 o 7 pm
                lbDespertar.text = h + ":0" + m + " AM"
            }else if enterosMin >= 10 && enteros >= 10{
                lbDespertar.text = h + ":" + m + " AM"
            }
        }
        else if enteros >= 12 {
            h = String(enteros)
            m = String(enterosMin)
            if enterosMin < 10 {
                lbDespertar.text = h + ":0" + m + " PM"
            }else{
                lbDespertar.text = h + ":" + m + " PM"
            }
        }
    }
    
    func dataFileURL() -> URL {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let pathArchivo = documentsDirectory.appendingPathComponent("Sueno").appendingPathExtension("plist")
            return pathArchivo
        }
        
        @IBAction func guardarDatos(){
            do{
                let data = try PropertyListEncoder().encode(listaSueno)
                try data.write(to: dataFileURL())
            }
            catch{
                print("Error al guardar los datos")
            }
        }
        
        func actualiza(){
            let hr = listaSueno[0].hora
            tfSueno.text =  String(hr!)
            //LABEL
            str2 = tfSueno.text
            let mySubstring = str2.prefix(2)
            let mySubstringM = str2.suffix(2)
            enteros2 = Int(mySubstring)
            enterosMin2 = Int(mySubstringM)
            enteros2 = enteros2 - 8
            if enteros2 == 0 {
                m2 = String(enterosMin2)
                if enterosMin2 < 10 {
                    lbDespertar.text = "00:0" + m2 + " AM"
                }else{
                    lbDespertar.text = "00:" + m2 + " AM"
                }
            }
            else if enteros2 < 0{//despertar a las 12am o después y antes de las 8am
                enteros2 = 21 + enteros2
                h2 = String(enteros2)
                m2 = String(enterosMin2)
                if enterosMin2 < 10 {
                    lbDespertar.text =  h2 + ":0" + m2 + " PM"
                }else{
                    lbDespertar.text =  h2 + ":" + m2 + " PM"
                }
            }
            else if enteros2 > 0 && enteros2 < 12{//despertar después de las 8am y antes de las 8pm
                h2 = String(enteros2)
                m2 = String(enterosMin2)
                if enterosMin2 < 10 && enteros2 < 10{
                    lbDespertar.text = "0" + h2 + ":0" + m2 + " AM"
                }else if enterosMin2 >= 10 && enteros2 < 10{
                    lbDespertar.text = "0" + h2 + ":" + m2 + " AM"
                }else if enterosMin2 < 10 && enteros2 >= 10{ //despertar a las 6 o 7 pm
                    lbDespertar.text = h2 + ":0" + m2 + " AM"
                }else if enterosMin2 >= 10 && enteros2 >= 10{
                    lbDespertar.text = h2 + ":" + m2 + " AM"
                }
            }
            else if enteros2 >= 12 {
                h2 = String(enteros2)
                m2 = String(enterosMin2)
                if enterosMin2 < 10 {
                    lbDespertar.text = h2 + ":0" + m2 + " PM"
                }else{
                    lbDespertar.text = h2 + ":" + m2 + " PM"
                }
            }
        }
        
    @IBAction func obtenerDatos() {
        listaSueno.removeAll()
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            listaSueno = try PropertyListDecoder().decode([Sueno].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
    }
    
    @IBAction func btGuardar(_ sender: UIButton) {
        hora = tfSueno.text!
        listaSueno = [Sueno(hora: hora)]
        guardarDatos()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRecordatorio(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "Recordatorio"
        content.subtitle = "Horas de sueño"
        content.body = "Es hora de dormir :)"
        content.badge = 1
        
        //SACA FECHA
        let date = Date()
        let formatter = DateFormatter()
        let year = formatter.string(from: date)
        let month = formatter.string(from: date)
        let day = formatter.string(from: date)
        
        //SACA HORA
        strNoti = lbDespertar.text
        let mySubstringHr = strNoti.prefix(2)
        //let mySubstringM = strNoti.suffix(2)
        let index = strNoti.index(strNoti.startIndex, offsetBy: 3)
        let endIndex = strNoti.index(strNoti.endIndex, offsetBy:-3)
        let mySubstringM =  strNoti[index ..< endIndex]
        horaNoti = Int(mySubstringHr)!
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
        vistaPopOver.texto = "Esto es un texto de prueba sobre el beneficio de horas de sueño"
    }
}
