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
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    var tiempo = ""
    var listaMeditacion = [Meditacion(tiempo: "00 : 00 : 00")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            let t = listaMeditacion.first?.tiempo
            lbCronometro.text = t
            
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
    
    @IBAction func btGuardarA(_ sender: UIButton) {
        let t = String(lbCronometro.text!)
        //tiempo = lbCronometro.text!
        listaMeditacion = [Meditacion(tiempo: t)]
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
        vistaPopOver.texto = "Lorem"
    }
}
