//
//  ViewControllerFrutas.swift
//  AppNutricion
//
//  Created by Chut on 13/10/21.
//

import UIKit

class ViewControllerFrutas: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var lbNumFrutas: UILabel!
    @IBOutlet weak var lbVerduras: UILabel!
    @IBOutlet weak var btnGuardar: UIButton!
    
    var fechaActual = DateComponents()
    var components = DateComponents()
    var listaFrutas = [Frutas]()
    var id = 5
    var frutas = 0
    var verduras = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Inicializa el arreglo con la fecha actual
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        components.day = day
        components.month = month
        components.year = year
        listaFrutas.append(Frutas(id: id, fruta: 0, verdura:0, fecha: .init(year:year, month: month, day: day)))
        
        //Estilo de labels
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
            
            let date = Date()
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            fechaActual.day = day
            fechaActual.month = month
            fechaActual.year = year
            
            if  fechaActual.day != listaFrutas[0].fecha.day || fechaActual.month != listaFrutas[0].fecha.month{
                
                lbNumFrutas.text = "0"
                lbVerduras.text = "0"
                
                let nuevasFrutas = Frutas(id: id, fruta: 0,verdura: 0, fecha: .init(year:fechaActual.year, month: fechaActual.month, day: fechaActual.day))
                listaFrutas.insert(nuevasFrutas, at: 0)
            
            }else{
                let f = listaFrutas[0].fruta
                lbNumFrutas.text =  String(f)
                
                let v = listaFrutas[0].verdura
                lbVerduras.text = String(v)
            }
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
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        components.day = day
        components.month = month
        components.year = year
        
        listaFrutas[0].id = id
        listaFrutas[0].fruta = frutas
        listaFrutas[0].verdura = verduras
        listaFrutas[0].fecha = components
        
        //listaFrutas = [Frutas(fruta: frutas, verdura: verduras)]
        guardarDatos()
        dismiss(animated: true, completion: nil)
    }
    
    // Para que no se adapte al tama??o de diferentes pantallas
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vistaPopOver = segue.destination as! ViewControllerPopOver
        vistaPopOver.popoverPresentationController?.delegate = self
        vistaPopOver.texto = #"No hay ning??n sumplento vit??minico como las frutas y verduras. "Eat the rainbow": Pensemos en el arco??ris cuando elegimos los vegetales que vamos a consumir."#
    }
    
    // MARK: - Limitar orientaci??n a portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
