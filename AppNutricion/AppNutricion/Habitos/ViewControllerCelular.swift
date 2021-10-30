//
//  ViewControllerCelular.swift
//  AppNutricion
//
//  Created by Estefy Charles on 30/10/21.
//

import UIKit

class ViewControllerCelular: UIViewController {
    
    @IBOutlet weak var lbHrsSinCel: UILabel!
    @IBOutlet weak var tfHrDormir: UITextField!
    @IBOutlet weak var btnGuardar: UIButton!
    
    var hora = "00:00"
    var hrsSinCel = 0
    var listaCelular = [Celular(hora: "00:00", hrsSin: 0)]
    
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
        listaCelular = [Celular(hora: hora, hrsSin: hrsSinCel)]
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
