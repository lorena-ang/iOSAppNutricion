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
    
    var listaSueno = [Sueno]()
    var horaDespertar = "00:00"
    var horaDormir = "00:00"
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
    var fechaActual = DateComponents()
    var components = DateComponents()
    var id = 8
    var completado = false

    override func viewDidLoad() {
        super.viewDidLoad()

        //Inicializa el arreglo con la fecha actual
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        components.day = day
        components.month = month
        components.year = year
        listaSueno.append(Sueno(id: id, horaDespertar: horaDespertar, horaDormir: horaDormir, completado: completado, fecha: .init(year:year, month:month, day:day)))
       ///
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
            //Obtiene fecha actual
            let date = Date()
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            fechaActual.day = day
            fechaActual.month = month
            fechaActual.year = year
            
            if  fechaActual.day != listaSueno[0].fecha.day || fechaActual.month != listaSueno[0].fecha.month{
                
                tfSueno.text = ""
                lbDespertar.text = ""
                
                let nuevoSueño = Sueno(id: id, horaDespertar: "0", horaDormir: "0", completado: completado, fecha: .init(year:fechaActual.year, month: fechaActual.month, day: fechaActual.day))
                listaSueno.insert(nuevoSueño, at: 0)
            }
            else{
                let hrDespertar = listaSueno[0].horaDespertar
                tfSueno.text =  String(hrDespertar!)
                //LABEL
                str2 = tfSueno.text
                let mySubstring = str2.prefix(2)
                let mySubstringM = str2.suffix(2)
                enteros2 = 0
                enteros2 = Int(mySubstring)
                enterosMin2 = Int(mySubstringM)
                enteros2 = enteros2 - 8
                if enteros2 == 0 {//despertar a las 8am
                    m2 = String(enterosMin2)
                    if enterosMin2 < 10 {
                        lbDespertar.text = "00:0" + m2 + " AM"
                    }else{
                        lbDespertar.text = "00:" + m2 + " AM"
                    }
                }
                else if enteros2 < 0{//despertar a las 12am o después y antes de las 8am
                    enteros2 = 24 + enteros2
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
        //ACTIVA NOTIFICACIÓN
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
        
        let dateA = Date()
        let calendar = Calendar.current
        let dayA = calendar.component(.day, from: dateA)
        let monthA = calendar.component(.month, from: dateA)
        let yearA = calendar.component(.year, from: dateA)
        components.day = dayA
        components.month = monthA
        components.year = yearA
        
        //GUARDA LA INFO EN EL ARREGLO
        horaDespertar = tfSueno.text!
        horaDormir = lbDespertar.text!
        completado = true
        
        listaSueno[0].id = id
        listaSueno[0].horaDespertar = horaDespertar
        listaSueno[0].horaDormir = horaDormir
        listaSueno[0].completado = completado
        listaSueno[0].fecha = components
        
        guardarDatos()
        dismiss(animated: true, completion: nil)
    }
    
    // Para que no se adapte al tamaño de diferentes pantallas
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vistaPopOver = segue.destination as! ViewControllerPopOver
        vistaPopOver.popoverPresentationController?.delegate = self
        vistaPopOver.texto = "Dormir bien y suficiente no es un lujo, es una necesidad del cuerpo para poder funcionar de manera adecuada. Una higiene del sueño deficiente, puede interferir en procesos de aprendizaje, almacenaje de memoria, la función inmunológica, entre muchos otros aspectos más."
    }
}
