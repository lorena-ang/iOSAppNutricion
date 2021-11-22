//
//  ViewControllerAgua.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class ViewControllerAgua: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var imgVaso1: UIImageView!
    @IBOutlet weak var imgVaso2: UIImageView!
    @IBOutlet weak var imgVaso3: UIImageView!
    @IBOutlet weak var imgVaso4: UIImageView!
    @IBOutlet weak var imgVaso5: UIImageView!
    @IBOutlet weak var imgVaso6: UIImageView!
    @IBOutlet weak var imgVaso7: UIImageView!
    @IBOutlet weak var imgVaso8: UIImageView!
    @IBOutlet weak var lbCantVasos: UILabel!
    @IBOutlet weak var btnGuardar: UIButton!
    
    var numVaso = 0
    var cant = 0
    var fechaActual = DateComponents()
    var components = DateComponents()
    var id = 7
    var listaVasos = [Agua]()

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
        listaVasos.append(Agua(id: id, vaso: 0, fecha: .init(year:year, month: month, day: day)))
        
        btnGuardar.layer.cornerRadius = 6

        // Do any additional setup after loading the view.
        let app = UIApplication.shared
                
                NotificationCenter.default.addObserver(self, selector: #selector(guardarDatos), name: UIApplication.didEnterBackgroundNotification, object: app)
                
                if FileManager.default.fileExists(atPath: dataFileURL().path){
                    obtenerDatos()
                }
                
                actualiza()
    }
    
    @IBAction func btnMas(_ sender: UIButton) {
        numVaso+=1
            if numVaso == 1 {
                imgVaso1.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("7")
            }else if numVaso == 2{
                imgVaso2.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("6")
            }else if numVaso == 3{
                imgVaso3.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("5")
            }else if numVaso == 4{
                imgVaso4.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("4")
            }else if numVaso == 5{
                imgVaso5.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("3")
            }else if numVaso == 6{
                imgVaso6.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("2")
            }else if numVaso == 7{
                imgVaso7.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("1")
            }else if numVaso == 8{
                imgVaso8.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("0")
            }else if numVaso >= 9 {
                numVaso = 8
            }
    }
    
    @IBAction func btnMenos(_ sender: UIButton) {
        if numVaso == 1 {
            imgVaso1.image = UIImage(named: "")
            lbCantVasos.text = String("8")
        }else if numVaso == 2{
            imgVaso2.image = UIImage(named: "")
            lbCantVasos.text = String("7")
        }else if numVaso == 3{
            imgVaso3.image = UIImage(named: "")
            lbCantVasos.text = String("6")
        }else if numVaso == 4{
            imgVaso4.image = UIImage(named: "")
            lbCantVasos.text = String("5")
        }else if numVaso == 5{
            imgVaso5.image = UIImage(named: "")
            lbCantVasos.text = String("4")
        }else if numVaso == 6{
            imgVaso6.image = UIImage(named: "")
            lbCantVasos.text = String("3")
        }else if numVaso == 7{
            imgVaso7.image = UIImage(named: "")
            lbCantVasos.text = String("2")
        }else if numVaso == 8{
            imgVaso8.image = UIImage(named: "")
            lbCantVasos.text = String("1")
        }
        if numVaso <= 0{
            numVaso = 0
        }else{
            numVaso-=1
        }
    }
    func dataFileURL() -> URL {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let pathArchivo = documentsDirectory.appendingPathComponent("Agua").appendingPathExtension("plist")
            //print(pathArchivo.path)
            return pathArchivo
    }
        
        @IBAction func guardarDatos(){
            do{
                let data = try PropertyListEncoder().encode(listaVasos)
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
            
            if  fechaActual.day != listaVasos[0].fecha.day || fechaActual.month != listaVasos[0].fecha.month{
                imgVaso1.image = UIImage(named: "")
                imgVaso2.image = UIImage(named: "")
                imgVaso3.image = UIImage(named: "")
                imgVaso4.image = UIImage(named: "")
                imgVaso5.image = UIImage(named: "")
                imgVaso6.image = UIImage(named: "")
                imgVaso7.image = UIImage(named: "")
                imgVaso8.image = UIImage(named: "")
                lbCantVasos.text = String("8")
                
                let nuevaAgua = Agua(id: id, vaso: 0,fecha: .init(year:fechaActual.year, month: fechaActual.month, day: fechaActual.day))
                listaVasos.insert(nuevaAgua, at: 0)
                
            }else{
                
                let v = listaVasos.first?.vaso
                if v == 1 {
                    imgVaso1.image = UIImage(named: "p12_vaso.png")
                    lbCantVasos.text = String("7")
                    numVaso = 1
                }else if v == 2{
                    imgVaso1.image = UIImage(named: "p12_vaso.png")
                    imgVaso2.image = UIImage(named: "p12_vaso.png")
                    lbCantVasos.text = String("6")
                    numVaso = 2
                }else if v == 3{
                    imgVaso1.image = UIImage(named: "p12_vaso.png")
                    imgVaso2.image = UIImage(named: "p12_vaso.png")
                    imgVaso3.image = UIImage(named: "p12_vaso.png")
                    lbCantVasos.text = String("5")
                    numVaso = 3
                }else if v == 4{
                    imgVaso1.image = UIImage(named: "p12_vaso.png")
                    imgVaso2.image = UIImage(named: "p12_vaso.png")
                    imgVaso3.image = UIImage(named: "p12_vaso.png")
                    imgVaso4.image = UIImage(named: "p12_vaso.png")
                    lbCantVasos.text = String("4")
                    numVaso = 4
                }else if v == 5{
                    imgVaso1.image = UIImage(named: "p12_vaso.png")
                    imgVaso2.image = UIImage(named: "p12_vaso.png")
                    imgVaso3.image = UIImage(named: "p12_vaso.png")
                    imgVaso4.image = UIImage(named: "p12_vaso.png")
                    imgVaso5.image = UIImage(named: "p12_vaso.png")
                    lbCantVasos.text = String("3")
                    numVaso = 5
                }else if v == 6{
                    imgVaso1.image = UIImage(named: "p12_vaso.png")
                    imgVaso2.image = UIImage(named: "p12_vaso.png")
                    imgVaso3.image = UIImage(named: "p12_vaso.png")
                    imgVaso4.image = UIImage(named: "p12_vaso.png")
                    imgVaso5.image = UIImage(named: "p12_vaso.png")
                    imgVaso6.image = UIImage(named: "p12_vaso.png")
                    lbCantVasos.text = String("2")
                    numVaso = 6
                }else if v == 7{
                    imgVaso1.image = UIImage(named: "p12_vaso.png")
                    imgVaso2.image = UIImage(named: "p12_vaso.png")
                    imgVaso3.image = UIImage(named: "p12_vaso.png")
                    imgVaso4.image = UIImage(named: "p12_vaso.png")
                    imgVaso5.image = UIImage(named: "p12_vaso.png")
                    imgVaso6.image = UIImage(named: "p12_vaso.png")
                    imgVaso7.image = UIImage(named: "p12_vaso.png")
                    lbCantVasos.text = String("1")
                    numVaso = 7
                }else if v == 8{
                    imgVaso1.image = UIImage(named: "p12_vaso.png")
                    imgVaso2.image = UIImage(named: "p12_vaso.png")
                    imgVaso3.image = UIImage(named: "p12_vaso.png")
                    imgVaso4.image = UIImage(named: "p12_vaso.png")
                    imgVaso5.image = UIImage(named: "p12_vaso.png")
                    imgVaso6.image = UIImage(named: "p12_vaso.png")
                    imgVaso7.image = UIImage(named: "p12_vaso.png")
                    imgVaso8.image = UIImage(named: "p12_vaso.png")
                    lbCantVasos.text = String("0")
                    numVaso = 8
                }
            }
        }
        
    @IBAction func obtenerDatos() {
        listaVasos.removeAll()
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            listaVasos = try PropertyListDecoder().decode([Agua].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
    }
    
    @IBAction func btGuardarA(_ sender: UIButton) {
        //cant = 8 - Int(lbCantVasos.text!)!
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        components.day = day
        components.month = month
        components.year = year
    
        listaVasos[0].id = id
        listaVasos[0].vaso = numVaso
        listaVasos[0].fecha = components
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
        vistaPopOver.texto = "El cuerpo requiere de agua para llevar a cabo inumerables funciones fisiológicas. Desde la lubricación de las articulaciones, a regular nuestra temperatura corporal y metabolismo. Incluso, tanto el cerebro y corazón de un adulto están compuestos por 3/4 de agua."
    }
    
    // MARK: - Limitar orientación a portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
