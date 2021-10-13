//
//  ViewControllerFrutas.swift
//  AppNutricion
//
//  Created by Chut on 13/10/21.
//

import UIKit

class ViewControllerFrutas: UIViewController {
    
    @IBOutlet weak var lbNumFrutas: UILabel!
    @IBOutlet weak var lbVerduras: UILabel!
    @IBOutlet weak var btnGuardar: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbNumFrutas.clipsToBounds = true
        lbNumFrutas.layer.cornerRadius = 6
        lbVerduras.clipsToBounds = true
        lbVerduras.layer.cornerRadius = 6
        btnGuardar.layer.cornerRadius = 6
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnMasFrutas(_ sender: UIButton) {
        guard let actual = Int(lbNumFrutas.text!) else {return}
        let nuevo = actual + 1
        lbNumFrutas!.text = String(nuevo)
    }
    
    @IBAction func btnMenosFrutas(_ sender: UIButton) {
        guard let actual = Int(lbNumFrutas.text!) else {return}
        if actual != 0 && actual > 0{
            let nuevo = actual - 1
            lbNumFrutas!.text = String(nuevo)
        }
    }
    
    @IBAction func btnMasVerduras(_ sender: UIButton) {
        guard let actual = Int(lbVerduras.text!) else {return}
        let nuevo = actual + 1
        lbVerduras!.text = String(nuevo)
    }
    
    @IBAction func btnMenosVerduras(_ sender: UIButton) {
        guard let actual = Int(lbVerduras.text!) else {return}
        if actual != 0 && actual > 0{
            let nuevo = actual - 1
            lbVerduras!.text = String(nuevo)
        }
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
