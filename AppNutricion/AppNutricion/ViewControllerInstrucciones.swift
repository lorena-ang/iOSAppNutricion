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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = vista.frame.size
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
