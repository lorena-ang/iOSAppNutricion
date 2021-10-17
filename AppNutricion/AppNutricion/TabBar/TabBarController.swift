//
//  TabBarController.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class TabBarController: UITabBarController {

    var habitosSeleccionados = [Habito]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
        // Do any additional setup after loading the view.
    }
}
