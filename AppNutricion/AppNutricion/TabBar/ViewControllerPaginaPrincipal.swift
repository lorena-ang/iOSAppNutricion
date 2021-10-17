//
//  ViewControllerPaginaPrincipal.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class ViewControllerPaginaPrincipal: UIViewController {
    
    @IBOutlet weak var collectionView: SeleccionCollectionView!
    
    var habitosSeleccionados = [Habito]()
    var identifier: String!
    
    @IBOutlet weak var btnAgregar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAgregar.layer.cornerRadius = 5
        collectionView.viewControllerPadre = self
        collectionView.allowsMultipleSelection = false
        collectionView.habitosSeleccionados = habitosSeleccionados
    }
    
    // Segues de hábitos
    func ejecutarSegue(identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    // MARK: - Navigation
    // Segue de selección
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segSeleccion" {
            let vistaSeleccion = segue.destination as! ViewControllerSeleccion
            vistaSeleccion.habitosSeleccionados = habitosSeleccionados
        }
    }
    
    @IBAction func unwindGuardarSeleccion(unwindSegue: UIStoryboardSegue)
    {
        if let sourceVC = unwindSegue.source as? ViewControllerSeleccion {
            collectionView.habitosSeleccionados = sourceVC.collectionView.habitosSeleccionadosNuevos
            collectionView.reloadData()
        }
    }
}
