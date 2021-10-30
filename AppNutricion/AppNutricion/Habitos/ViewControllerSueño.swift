//
//  ViewControllerSueño.swift
//  AppNutricion
//
//  Created by Chut on 29/10/21.
//

import UIKit

class ViewControllerSuen_o: UIViewController {
    
    @IBOutlet weak var tfSueno: UITextField!
    @IBOutlet weak var btnGuardar: UIButton!
    
    var listaSueno = [Sueno(hora: "00:00")]
    var hora = "00:00"

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
            
            let h = listaSueno[0].hora
            tfSueno.text =  String(h!)
            
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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
