//
//  ViewControllerFrutas.swift
//  AppNutricion
//
//  Created by Chut on 13/10/21.
//

import UIKit

class ViewControllerFrutas: UIViewController {
    
    @IBOutlet weak var lbNumFrutas: UILabel!
    @IBOutlet weak var lbVerduras: UILabel!
    @IBOutlet weak var btnGuardar: UIButton!
    
    var listaFrutas = [Frutas(fruta: 0, verdura: 0)]
    var frutas = 0
    var verduras = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbNumFrutas.clipsToBounds = true
        lbNumFrutas.layer.cornerRadius = 6
        lbNumFrutas.layer.borderWidth = 0.4
        lbNumFrutas.layer.borderColor = UIColor.lightGray.cgColor
        lbVerduras.clipsToBounds = true
        lbVerduras.layer.cornerRadius = 6
        lbVerduras.layer.borderWidth = 0.4
        lbVerduras.layer.borderColor = UIColor.lightGray.cgColor
        btnGuardar.layer.cornerRadius = 6
        // Do any additional setup after loading the view.
        let app = UIApplication.shared
                
                NotificationCenter.default.addObserver(self, selector: #selector(guardarDatos), name: UIApplication.didEnterBackgroundNotification, object: app)
                
                if FileManager.default.fileExists(atPath: dataFileURL().path){
                    obtenerDatos()
                }
                
                actualiza()
    }
    
    @IBAction func btnMasFrutas(_ sender: UIButton) {
        guard let actual = Int(lbNumFrutas.text!) else {return}
        let nuevo = actual + 1
        lbNumFrutas!.text = String(nuevo)
    }
    
    @IBAction func btnMenosFrutas(_ sender: UIButton) {
        guard let actual = Int(lbNumFrutas.text!) else {return}
        if actual != 0 && actual > 0{
            let nuevo = actual - 1
            lbNumFrutas!.text = String(nuevo)
        }
    }
    
    @IBAction func btnMasVerduras(_ sender: UIButton) {
        guard let actual = Int(lbVerduras.text!) else {return}
        let nuevo = actual + 1
        lbVerduras!.text = String(nuevo)
    }
    
    @IBAction func btnMenosVerduras(_ sender: UIButton) {
        guard let actual = Int(lbVerduras.text!) else {return}
        if actual != 0 && actual > 0{
            let nuevo = actual - 1
            lbVerduras!.text = String(nuevo)
        }
    }
    
    func dataFileURL() -> URL {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let pathArchivo = documentsDirectory.appendingPathComponent("Frutas").appendingPathExtension("plist")
            //print(pathArchivo.path)
            return pathArchivo
        }
        
        @IBAction func guardarDatos(){
            do{
                let data = try PropertyListEncoder().encode(listaFrutas)
                try data.write(to: dataFileURL())
            }
            catch{
                print("Error al guardar los datos")
            }
        }
        
        func actualiza(){
            
            let f = listaFrutas[0].fruta
            lbNumFrutas.text =  String(f!)
            
            let v = listaFrutas[0].verdura
            lbVerduras.text = String(v!)
        }
        
    @IBAction func obtenerDatos() {
        listaFrutas.removeAll()
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            listaFrutas = try PropertyListDecoder().decode([Frutas].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
    }
    
    @IBAction func btGuardarA(_ sender: UIButton) {
        frutas = Int(lbNumFrutas.text!)!
        verduras = Int(lbVerduras.text!)!
        listaFrutas = [Frutas(fruta: frutas, verdura: verduras)]
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
