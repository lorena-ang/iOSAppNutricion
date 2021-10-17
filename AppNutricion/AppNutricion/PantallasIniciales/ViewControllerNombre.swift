//
//  ViewControllerNombre.swift
//  AppNutricion
//
//  Created by Lore Ang on 16/10/21.
//

import UIKit

class ViewControllerNombre: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var btnComenzar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnComenzar.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Guardar en UserDefaults
        let defaults = UserDefaults.standard
        defaults.setValue(tfNombre.text, forKey: "nombre")
    }
    
    @IBAction func quitateclado() {
        view.endEditing(true)
    }
}
