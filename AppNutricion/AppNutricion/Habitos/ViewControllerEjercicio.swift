//
//  ViewControllerEjercicio.swift
//  AppNutricion
//
//  Created by Chut on 30/10/21.
//

import UIKit

class ViewControllerEjercicio: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tfEjercicio: UITextField!
    @IBOutlet weak var btnGuardar: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    
    var fechaActual = DateComponents()
    var components = DateComponents()
    var listaEjercicio = [Ejercicio]()
    var hora = "00:00"
    var check = "true"
    var id = 1
    
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
        listaEjercicio.append(Ejercicio(id: id, hora: "00:00", check: "false", fecha: .init(year:year, month: month, day: day)))

        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        tfEjercicio.text = formatter.string(from: time)
        tfEjercicio.textColor = .link
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .countDownTimer
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 250)
        
        timePicker.preferredDatePickerStyle = .wheels
        
        tfEjercicio.inputView = timePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewControllerEjercicio.viewTapped(gestureRecognizer: )))
        view.addGestureRecognizer(tapGesture)
        
        btnGuardar.layer.cornerRadius = 6
        
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
        tfEjercicio.text = formatter.string(from: sender.date)
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
    
    
    func dataFileURL() -> URL {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let pathArchivo = documentsDirectory.appendingPathComponent("Ejercicio").appendingPathExtension("plist")
            return pathArchivo
        }
        
        @IBAction func guardarDatos(){
            do{
                let data = try PropertyListEncoder().encode(listaEjercicio)
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
        
        if  fechaActual.day != listaEjercicio[0].fecha.day || fechaActual.month != listaEjercicio[0].fecha.month{
            
            tfEjercicio.text = "00:00"
            btnCheck.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            
            let nuevoEjercicio = Ejercicio(id: id, hora: "00:00", check: "false", fecha: .init(year:fechaActual.year, month: fechaActual.month, day: fechaActual.day))
            listaEjercicio.insert(nuevoEjercicio, at: 0)
            
        }else{
            let hr = listaEjercicio[0].hora
            tfEjercicio.text =  String(hr!)
            
            let ch = listaEjercicio[0].check
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
        listaEjercicio.removeAll()
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            listaEjercicio = try PropertyListDecoder().decode([Ejercicio].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
    }
    
    @IBAction func btnGuardarA(_ sender: UIButton) {
        hora = tfEjercicio.text!
        //listaEjercicio = [Ejercicio(hora: hora)]
        if check == "true"{
            check = "false"
        }else{
            check = "true"
        }
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        components.day = day
        components.month = month
        components.year = year
        
        listaEjercicio[0].id = id
        listaEjercicio[0].hora = hora
        listaEjercicio[0].check = check
        listaEjercicio[0].fecha = components
        //listaEjercicio = [Ejercicio(hora: hora, check: check)]
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
        vistaPopOver.texto = "Trata de realizar al menos 45 minutos de ejercicio intenso. Los días que no te sea posible, 15 o 20 min también ¡son excelentes!"
    }
    
    // MARK: - Limitar orientación a portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
