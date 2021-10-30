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
    @IBOutlet weak var lbDespertar: UILabel!
    
    var listaSueno = [Sueno(hora: "00:00")]
    var hora = "00:00"
    var str : String!
    var str2 : String!
    var enteros2 : Int!
    var enteros : Int!
    var h : String!
    var h2 : String!
    

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
        str = tfSueno.text
        let mySubstring = str.prefix(2)
        enteros = Int(mySubstring)
        enteros = enteros - 8
        if enteros == 0 {
            lbDespertar.text = "00:00 AM"
        }
        else if enteros < 0{
            enteros = 12 + enteros
            h = String(enteros)
            lbDespertar.text =  h + ":00 PM"
        }
        else if enteros > 0 && enteros < 10{
            h = String(enteros)
            lbDespertar.text = "0" + h + ":00 AM"
        }
        else if enteros >= 10 && enteros < 12{
            h = String(enteros)
            lbDespertar.text = h + ":00 AM"
        }
        else if enteros >= 12 {
            h = String(enteros)
            lbDespertar.text = h + ":00 PM"
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
            enteros2 = Int(mySubstring)
            enteros2 = enteros2 - 8
            if enteros2 == 0 {
                lbDespertar.text = "00:00 AM"
            }
            else if enteros2 < 0{
                enteros2 = 12 + enteros2
                h2 = String(enteros2)
                lbDespertar.text =  h2 + ":00 PM"
            }
            else if enteros2 > 0 && enteros2 < 10{
                h2 = String(enteros2)
                lbDespertar.text = "0" + h2 + ":00 AM"
            }
            else if enteros2 >= 10 && enteros2 < 12{
                h2 = String(enteros2)
                lbDespertar.text = h2 + ":00 AM"
            }
            else if enteros2 >= 12 {
                h2 = String(enteros2)
                lbDespertar.text = h2 + ":00 PM"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
