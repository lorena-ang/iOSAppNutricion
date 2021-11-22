//
//  ViewControllerMeditacion.swift
//  AppNutricion
//
//  Created by Chut on 13/10/21.
//

import UIKit

class ViewControllerMeditacion: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var btnGuardar: UIButton!
    @IBOutlet weak var btnIniciar: UIButton!
    @IBOutlet weak var lbCronometro: UILabel!
    @IBOutlet weak var tfMeditacion: UITextField!
    @IBOutlet weak var btnCheck: UIButton!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    var tiempo = ""
    var hora = "00:00"
    var check = "true"
    var fechaActual = DateComponents()
    var components = DateComponents()
    var id = 6
    var listaMeditacion = [Meditacion]()
    //var listaMeditacion = [Meditacion(tiempo: "00 : 00 : 00", hora: "00:00", check: "false")]
    
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
        listaMeditacion.append(Meditacion(id: id, tiempo: "00 : 00 : 00", hora: "00:00", check: "false", fecha: .init(year:year, month: month, day: day)))
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        tfMeditacion.text = formatter.string(from: time)
        //tfMeditacion.textColor = .link
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .countDownTimer
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 250)
        
        timePicker.preferredDatePickerStyle = .wheels
        
        tfMeditacion.inputView = timePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewControllerMeditacion.viewTapped(gestureRecognizer: )))
        view.addGestureRecognizer(tapGesture)
        
        btnGuardar.layer.cornerRadius = 6
        btnIniciar.layer.cornerRadius = 6

        // Do any additional setup after loading the view.
        let app = UIApplication.shared
                
                NotificationCenter.default.addObserver(self, selector: #selector(guardarDatos), name: UIApplication.didEnterBackgroundNotification, object: app)
                
                if FileManager.default.fileExists(atPath: dataFileURL().path){
                    obtenerDatos()
                }
                
                actualiza()
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func timePickerValueChanged(sender:UIDatePicker){
        //cuando el tiempo se cambia, va aparecer aqui
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        tfMeditacion.text = formatter.string(from: sender.date)
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
            let pathArchivo = documentsDirectory.appendingPathComponent("Meditacion").appendingPathExtension("plist")
            //print(pathArchivo.path)
            return pathArchivo
        }
        
        @IBAction func guardarDatos(){
            do{
                let data = try PropertyListEncoder().encode(listaMeditacion)
                try data.write(to: dataFileURL())
            }
            catch{
                print("Error al guardar los datos")
            }
        }
        
        func actualiza(){
            
            let date = Date()
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            fechaActual.day = day
            fechaActual.month = month
            fechaActual.year = year
            
            if  fechaActual.day != listaMeditacion[0].fecha.day || fechaActual.month != listaMeditacion[0].fecha.month{
                
                lbCronometro.text = "00 : 00 : 00"
                tfMeditacion.text = "00:00"
                btnCheck.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
                
                let nuevaMeditacion = Meditacion(id: id, tiempo: "00 : 00 : 00", hora: "00:00", check: "false", fecha: .init(year:fechaActual.year, month: fechaActual.month, day: fechaActual.day))
                listaMeditacion.insert(nuevaMeditacion, at: 0)
                
            }else{
                //let t = listaMeditacion.first?.tiempo
                //lbCronometro.text = t
                let t = listaMeditacion[0].tiempo
                lbCronometro.text = t
                
                let hr = listaMeditacion[0].hora
                tfMeditacion.text = hr
                
                let ch = listaMeditacion[0].check
                if ch == "true" {
                    btnCheck.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
                    check = "false"
                }else{
                    btnCheck.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
                    check = "true"
                }
            }
            
        }
        
    @IBAction func obtenerDatos() {
        listaMeditacion.removeAll()
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            listaMeditacion = try PropertyListDecoder().decode([Meditacion].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
    }
    
    @IBAction func btnCheckA(_ sender: UIButton) {
        if check == "true" {
            sender.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
            check = "false"
        }else{
            sender.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            check = "true"
        }
    }
    
    
    @IBAction func btGuardarA(_ sender: UIButton) {
        hora = tfMeditacion.text!
        if check == "true"{
            check = "false"
        }else{
            check = "true"
        }
        let t = String(lbCronometro.text!)
        //tiempo = lbCronometro.text!
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        components.day = day
        components.month = month
        components.year = year
        
        listaMeditacion[0].id = id
        listaMeditacion[0].tiempo = t
        listaMeditacion[0].hora = hora
        listaMeditacion[0].check = check
        listaMeditacion[0].fecha = components
        
        //listaMeditacion = [Meditacion(tiempo: t,hora: hora, check: check)]
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
        vistaPopOver.texto = "Te ayuda a conocer tu mente, regular emociones, ser más resiliente, compasivo y ecuánime, además de la tranquilidad y calma que te otorga."
    }
    
    // MARK: - Limitar orientación a portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
