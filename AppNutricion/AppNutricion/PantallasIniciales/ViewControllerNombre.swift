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
    
    @IBAction func quitateclado() {
        view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "segGuardarNombre" {
            let nombre = tfNombre.text
            if !nombre!.isEmpty {
                return true
            }
        }
        return false
    }
    
    // MARK: - Limitar orientación a portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
