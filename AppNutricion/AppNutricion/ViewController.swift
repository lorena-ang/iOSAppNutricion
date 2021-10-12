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
    
    override func viewWillDisappear(_ animated: Bool) {
        habitosSeleccionados = collectionView.habitosSeleccionados
    }
}

