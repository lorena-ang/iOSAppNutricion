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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.allowsMultipleSelection = true
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        habitosSeleccionados = collectionView.habitosSeleccionados
        // Ordenar hábitos por id
        habitosSeleccionados.sort { (h1, h2) in
            h1.id < h2.id
        }
        let vistaTab = segue.destination as! TabBarController
        vistaTab.habitosSeleccionados = habitosSeleccionados
        // Enviar a perfil
        let vistaPerfil = vistaTab.viewControllers?[0] as! ViewControllerPerfil
        vistaPerfil.habitosSeleccionados = habitosSeleccionados
        // Enviar a página principal
        let vistaPaginaPrincipal = vistaTab.viewControllers?[1] as! ViewControllerPaginaPrincipal
        vistaPaginaPrincipal.habitosSeleccionados = habitosSeleccionados
    }
}
