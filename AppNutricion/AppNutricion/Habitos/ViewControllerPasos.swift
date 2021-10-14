//
//  ViewControllerPasos.swift
//  AppNutricion
//
//  Created by Chut on 13/10/21.
//

import UIKit

class ViewControllerPasos: UIViewController {
    
    @IBOutlet weak var tfPasos: UITextField!
    @IBOutlet weak var btnGuardar: UIButton!
    
    var listaPasos = [Pasos]()
    var pasos = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        btnGuardar.layer.cornerRadius = 6
        // Do any additional setup after loading the view.
        let app = UIApplication.shared
                
                NotificationCenter.default.addObserver(self, selector: #selector(guardarDatos), name: UIApplication.didEnterBackgroundNotification, object: app)
                
                if FileManager.default.fileExists(atPath: dataFileURL().path){
                    obtenerDatos()
                }
                
                actualiza()
    }
    
    func dataFileURL() -> URL {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let pathArchivo = documentsDirectory.appendingPathComponent("Pasos").appendingPathExtension("plist")
            //print(pathArchivo.path)
            return pathArchivo
        }
        
        @IBAction func guardarDatos(){
            do{
                let data = try PropertyListEncoder().encode(listaPasos)
                try data.write(to: dataFileURL())
            }
            catch{
                print("Error al guardar los datos")
            }
        }
        
        func actualiza(){
            let p = listaPasos[0].pasos
            tfPasos.text = String(p!)
        }
        
    @IBAction func obtenerDatos() {
        listaPasos.removeAll()
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            listaPasos = try PropertyListDecoder().decode([Pasos].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
    }
    
    @IBAction func btGuardarA(_ sender: UIButton) {
        if tfPasos.hasText{
            pasos = Int(tfPasos.text!)!
        }else{
            tfPasos.text = "0"
            pasos = Int(tfPasos.text!)!
        }
        listaPasos = [Pasos(pasos: pasos)]
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
