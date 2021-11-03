//
//  ViewControllerSeleccion.swift
//  AppNutricion
//
//  Created by Lore Ang on 16/10/21.
//

import UIKit

class ViewControllerSeleccion: UIViewController {

    @IBOutlet weak var collectionView: SeleccionEditarCollectionView!
    var habitosSeleccionados = [Habito]()
    var habitoIds = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.allowsMultipleSelection = true
        collectionView.habitosSeleccionados = habitosSeleccionados
    }
}
