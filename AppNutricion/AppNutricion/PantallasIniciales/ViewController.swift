//
//  ViewController.swift
//  AppNutricion
//
//  Created by Lore Ang on 11/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: CustomCollectionView!
    var habitosSeleccionados = [Habito]()
    var habitoIds = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.allowsMultipleSelection = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "viewsIniciales")
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        habitosSeleccionados = collectionView.habitosSeleccionados
        
        // Ordenar hábitos por id
        habitosSeleccionados.sort { (h1, h2) in
            h1.id < h2.id
        }
        
        // Almacenar ids de hábitos seleccionados en userDefaults
        for habito in habitosSeleccionados {
            habitoIds.append(habito.id)
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(habitoIds, forKey: "habitoIds")
        
        let vistaTab = segue.destination as! TabBarController
        vistaTab.habitosSeleccionados = habitosSeleccionados
        // Enviar a perfil
        let vistaPerfil = vistaTab.viewControllers?[0] as! ViewControllerPerfil
        vistaPerfil.habitoIds = habitoIds

        // Enviar a página principal
        let vistaPaginaPrincipal = vistaTab.viewControllers?[1] as! ViewControllerPaginaPrincipal
        vistaPaginaPrincipal.habitoIds = habitoIds
    }
    
    // MARK: - Limitar orientación a portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
