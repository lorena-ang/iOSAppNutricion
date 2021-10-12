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
        print(habitosSeleccionados)
        print("TabBarController")
        let vcPaginaPrincipal = ViewControllerPaginaPrincipal()
        vcPaginaPrincipal.habitosSeleccionados = habitosSeleccionados
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        self.viewControllers?[0] = ViewControllerPerfil()
        self.viewControllers?[1] = ViewControllerPaginaPrincipal()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vcPaginaPrincipal = segue.destination as! ViewControllerPaginaPrincipal // second view controller
        vcPaginaPrincipal.habitosSeleccionados = habitosSeleccionados
    }
 */
}
