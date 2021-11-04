//
//  ViewControllerBreaks.swift
//  AppNutricion
//
//  Created by Lore Ang on 01/11/21.
//

import UIKit

class ViewControllerBreaks: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tfBreaks: UITextField!
    @IBOutlet weak var btnIniciar: UIButton!
    @IBOutlet weak var btnGuardar: UIButton!
    @IBOutlet weak var lbCronometro: UILabel!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    var tiempo = ""
    var hora = "00:00"
    var listaBreaks = [Breaks(tiempo: "00 : 00 : 00", hora: "00:00")]
    var str : String!
    var doubleMin : Double!
    var doubleHr : Double!
    var timeNoti : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        tfBreaks.text = formatter.string(from: time)
        tfBreaks.textColor = .link
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .countDownTimer
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 250)
        
        timePicker.preferredDatePickerStyle = .wheels
        
        tfBreaks.inputView = timePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewControllerBreaks.viewTapped(gestureRecognizer: )))
        view.addGestureRecognizer(tapGesture)
        
        btnGuardar.layer.cornerRadius = 6
        btnIniciar.layer.cornerRadius = 6
        
        let app = UIApplication.shared
                
                NotificationCenter.default.addObserver(self, selector: #selector(guardarDatos), name: UIApplication.didEnterBackgroundNotification, object: app)
                
                if FileManager.default.fileExists(atPath: dataFileURL().path){
                    obtenerDatos()
                }
                
                actualiza()
        
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
        tfBreaks.text = formatter.string(from: sender.date)
    }
    
    @IBAction func btnStart(_ sender: UIButton) {
        if(timerCounting){
            timerCounting = false
            timer.invalidate()
            btnIniciar.setTitle("Iniciar", for: .normal)
        }else{
            timerCounting = true
            btnIniciar.setTitle("Detener", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimerString(hours: time.0, minutes: time.1, seconds: time.2)
        lbCronometro.text = timeString
        //let h = makeTimerStringS(hours: time.0, minutes: time.1, seconds: time.2)
    }
    
    func secondsToHoursMinutesSeconds(seconds:Int) -> (Int,Int,Int){
        return (seconds / 3600, (seconds % 3600)/60, ((seconds % 3600)%60))
    }
    
    func makeTimerString(hours: Int, minutes: Int, seconds: Int) -> String{
        var timeString = ""
        timeString += String(format: "%02d", hours)
        //hr += Int("%02d", radix: hours)!
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
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
        let t = listaBreaks[0].tiempo
        lbCronometro.text = t
        
        let hr = listaBreaks[0].hora
        tfBreaks.text = hr
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
        hora = tfBreaks.text!
        let t = String(lbCronometro.text!)
        //tiempo = lbCronometro.text!
        listaBreaks = [Breaks(tiempo: t,hora: hora)]
        guardarDatos()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRecordatorio(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "Break"
        content.subtitle = "Break"
        content.body = "Break"
        content.badge = 1
        
        str = tfBreaks.text
        let mySubstringHr = str.prefix(2)
        let mySubstringM = str.suffix(2)
        doubleHr = Double(mySubstringHr)! * 3600
        doubleMin = Double(mySubstringM)! * 60
        timeNoti = doubleHr + doubleMin
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeNoti, repeats: true)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vistaPopOver = segue.destination as! ViewControllerPopOver
        vistaPopOver.popoverPresentationController?.delegate = self
        vistaPopOver.texto = "Esto es un texto de prueba sobre el beneficio de breaks de actividades"
    }
}
