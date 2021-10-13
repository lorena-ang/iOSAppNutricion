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
    
    func ejecutarSegue(identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    // funcion ejecutar segue recibiendo como parametro el segue
}
