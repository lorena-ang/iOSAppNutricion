//
//  ViewControllerComidas.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class ViewControllerComidas: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var desayuno = true
    var comida = true
    var cena = true
    var fechaActual = DateComponents()
    var components = DateComponents()
    var listaComidas = [Comidas]()
    var id = 3
    
    @IBOutlet weak var btCheckD: UIButton!
    @IBOutlet weak var btCheckCo: UIButton!
    @IBOutlet weak var btCheckCe: UIButton!
    
    @IBOutlet weak var btnGuardar: UIButton!

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
        listaComidas.append(Comidas(id: id, desayuno: false, comida: false, cena: false, fecha: .init(year:year, month: month, day: day)))
        
        btnGuardar.layer.cornerRadius = 6
        // Do any additional setup after loading the view.
        let app = UIApplication.shared
                
                NotificationCenter.default.addObserver(self, selector: #selector(guardarDatos), name: UIApplication.didEnterBackgroundNotification, object: app)
                
                if FileManager.default.fileExists(atPath: dataFileURL().path){
                    obtenerDatos()
                }
        
                actualiza()
        
    }
    
    @IBAction func btnDesayuno(_ sender: UIButton) {
        if desayuno {
            sender.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
            desayuno = false
        }else{
            sender.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            desayuno = true
        }
    }
    
    @IBAction func btnComida(_ sender: UIButton) {
        if comida {
            sender.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
            comida = false
        }else{
            sender.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            comida = true
        }
    }
    
    @IBAction func btnCena(_ sender: UIButton) {
        if cena {
            sender.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
            cena = false
        }else{
            sender.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            cena = true
        }
    }
    
    func dataFileURL() -> URL {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let pathArchivo = documentsDirectory.appendingPathComponent("Comidas").appendingPathExtension("plist")
            //print(pathArchivo.path)
            return pathArchivo
        }
        
        @IBAction func guardarDatos(){
            do{
                let data = try PropertyListEncoder().encode(listaComidas)
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
        
        if  fechaActual.day != listaComidas[0].fecha.day || fechaActual.month != listaComidas[0].fecha.month{
            btCheckD.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            desayuno = true
            btCheckCo.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            comida = true
            btCheckCe.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            cena = true
            let nuevaComida = Comidas(id: id, desayuno: desayuno, comida: comida, cena: cena, fecha: .init(year:fechaActual.year, month: fechaActual.month, day: fechaActual.day))
            listaComidas.insert(nuevaComida, at: 0)
        }
        else{
            let des = listaComidas[0].desayuno
            if des {
                btCheckD.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
                desayuno = false
            }else{
                btCheckD.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
                desayuno = true
            }
            let com = listaComidas[0].comida
            if com {
                btCheckCo.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
                comida = false
            }else{
                btCheckCo.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
                comida = true
            }
            let cen = listaComidas[0].cena
            if cen {
                btCheckCe.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
                cena = false
            }else{
                btCheckCe.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
                cena = true
            }
        }
       
    }

        @IBAction func obtenerDatos(){
            listaComidas.removeAll()
            do{
                let data = try Data.init(contentsOf: dataFileURL())
                listaComidas = try PropertyListDecoder().decode([Comidas].self, from: data)
            }
            catch{
                print("Error al cargar los datos del archivo")
            }
            
        }
    
    @IBAction func btGuardarA(_ sender: UIButton) {
        if desayuno{
            desayuno = false
        }else{
            desayuno = true
        }
        if comida{
            comida = false
        }else{
            comida = true
        }
        if cena{
            cena = false
        }else{
            cena = true
        }
        //FECHA
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        components.day = day
        components.month = month
        components.year = year
        print(components)
        //listaComidas = [Comidas(desayuno: desayuno, comida: comida, cena: cena, fecha: components)]
        listaComidas[0].id = id
        listaComidas[0].desayuno = desayuno
        listaComidas[0].comida = comida
        listaComidas[0].cena = cena
        listaComidas[0].fecha = components
 
        guardarDatos()
        dismiss(animated: true, completion: nil)
    }
    
    // Para que no se adapte al tama??o de diferentes pantallas
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guardarDatos()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vistaPopOver = segue.destination as! ViewControllerPopOver
        vistaPopOver.popoverPresentationController?.delegate = self
        vistaPopOver.texto = "No podemos nutrir nuestro cuerpo con solo 1 plato saludable, trata de integrar todos los grupos de alimentos, especialmente: vegetales, cereales integrales, grasas saludables en moderaci??n y prote??na baja en grasa (animal y/o vegetal)."
    }
    
    // MARK: - Limitar orientaci??n a portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
