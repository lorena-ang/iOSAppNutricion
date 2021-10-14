//
//  ViewControllerComidas.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class ViewControllerComidas: UIViewController {
    
    var desayuno = true
    var comida = true
    var cena = true
    var listaComidas = [Comidas(desayuno: false, comida: false, cena: false)]
    
    @IBOutlet weak var btCheckD: UIButton!
    @IBOutlet weak var btCheckCo: UIButton!
    @IBOutlet weak var btCheckCe: UIButton!
    
    @IBOutlet weak var btnGuardar: UIButton!

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
            //Porque despues de bajar la pantalla y al volver accesar, tenias que dar doble click para activar el boton y con estos if se soluciona
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
            let des = listaComidas[0].desayuno
            if des {
                btCheckD.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
            }else{
                btCheckD.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            }
            let com = listaComidas[0].comida
            if com {
                btCheckCo.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
            }else{
                btCheckCo.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            }
            let cen = listaComidas[0].cena
            if cen {
                btCheckCe.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
            }else{
                btCheckCe.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
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
        /*if desayuno{
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
        }*/
        //listaComidas = [Comidas(desayuno: desayuno, comida: comida, cena: cena)]
        listaComidas[0].desayuno = desayuno
        listaComidas[0].comida = comida
        listaComidas[0].cena = cena
        
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
