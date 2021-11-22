//
//  ViewControllerInstrucciones.swift
//  AppNutricion
//
//  Created by Lore Ang on 01/11/21.
//

import UIKit

class ViewControllerInstrucciones: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vista: UIView!
    
    @IBOutlet weak var btnCreditos: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = vista.frame.size
        btnCreditos.layer.cornerRadius = 5
    }
}
