//
//  ViewControllerPasos.swift
//  AppNutricion
//
//  Created by Chut on 13/10/21.
//

import UIKit

class ViewControllerPasos: UIViewController {
    
    @IBOutlet weak var tfPasos: UITextField!
    @IBOutlet weak var btnGuardar: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        btnGuardar.layer.cornerRadius = 6

        // Do any additional setup after loading the view.
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
