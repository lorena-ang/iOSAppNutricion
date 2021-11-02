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

        preferredContentSize = CGSize(width: 320, height: 460)
        lbTexto.text = texto
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
