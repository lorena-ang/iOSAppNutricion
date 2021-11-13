//
//  ViewControllerPasos.swift
//  AppNutricion
//
//  Created by Chut on 13/10/21.
//

import UIKit

class ViewControllerPasos: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tfPasos: UITextField!
    @IBOutlet weak var btnGuardar: UIButton!
    
    var fechaActual = DateComponents()
    var components = DateComponents()
    //var listaPasos = [Pasos(pasos: 0)]
    var listaPasos = [Pasos]()
    var pasos = 0

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
        listaPasos.append(Pasos(pasos: 0, fecha: .init(year: year, month: month, day: day)))
        
        
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
            
            let date = Date()
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            fechaActual.day = 13
            fechaActual.month = month
            fechaActual.year = year
            if  fechaActual.day != listaPasos[0].fecha.day || fechaActual.month != listaPasos[0].fecha.month{
                
                tfPasos.text = ""
                
                let nuevosPasos = Pasos(pasos: 0,fecha: .init(year:fechaActual.year, month: fechaActual.month, day: fechaActual.day))
                listaPasos.insert(nuevosPasos, at: 0)
                
            }else{
                let p = listaPasos[0].pasos
                tfPasos.text = String(p!)
            }
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
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        components.day = 13
        components.month = month
        components.year = year
        print(components)
        //listaPasos = [Pasos(pasos: pasos, fecha:components)]
        listaPasos[0].pasos = pasos
        listaPasos[0].fecha = components
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
        vistaPopOver.texto = "Aumentar el nivel de actividad física trae enormes beneficios a la salud, sobre todo la salud cardiovascular ❤️. Además de hacer ejercicio, es importante también la actividad física para no ser sedentarios."
    }
}
