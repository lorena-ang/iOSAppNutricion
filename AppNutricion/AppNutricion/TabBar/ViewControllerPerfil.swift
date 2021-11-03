//
//  ViewControllerPerfil.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class ViewControllerPerfil: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    
    var habitosSeleccionados = [Habito]()
    var habitoIds = [Any]()
    var nombre: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfNombre.layer.cornerRadius = 5
        let defaults = UserDefaults.standard
        nombre = defaults.value(forKey: "nombre") as! String
        tfNombre.text = nombre
    }

    @IBAction func quitateclado() {
        view.endEditing(true)
        let nuevoNombre = tfNombre.text
        // Actualizar cambio en UserDefaults si hubo
        if nombre != nuevoNombre {
            let defaults = UserDefaults.standard
            defaults.setValue(tfNombre.text, forKey: "nombre")
        }
    }
}
