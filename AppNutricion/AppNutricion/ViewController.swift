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
    
    /*
    override func viewWillDisappear(_ animated: Bool) {
        habitosSeleccionados = collectionView.habitosSeleccionados
    }
    */
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //vistaPrincipal.habitosSeleccionados = habitosSeleccionados;
        habitosSeleccionados = collectionView.habitosSeleccionados
        let vistaTab = segue.destination as! TabBarController
        vistaTab.habitosSeleccionados = habitosSeleccionados
    }
}

