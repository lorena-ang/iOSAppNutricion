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
    var viewsIniciales: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnComenzar.layer.cornerRadius = 5
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Guardar en UserDefaults
        let defaults = UserDefaults.standard
        defaults.setValue(tfNombre.text, forKey: "nombre")
    }
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard
        viewsIniciales = defaults.bool(forKey: "viewsIniciales")
        
        if viewsIniciales {
            performSegue(withIdentifier: "segGuardarNombre", sender: self)
        }
    }
 */
    
    @IBAction func quitateclado() {
        view.endEditing(true)
    }
}
