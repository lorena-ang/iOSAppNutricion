//
//  ViewControllerPopOver.swift
//  AppNutricion
//
//  Created by Lore Ang on 25/10/21.
//

import UIKit

class ViewControllerPopOver: UIViewController {

    @IBOutlet weak var lbTexto: UILabel!
    var texto: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preferredContentSize = CGSize(width: 320, height: 300)
        lbTexto.text = texto
    }
    
    // MARK: - Limitar orientación a portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
