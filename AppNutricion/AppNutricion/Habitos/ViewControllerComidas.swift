//
//  ViewControllerComidas.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class ViewControllerComidas: UIViewController {
    
    var desayuno = true
    var comida = true
    var cena = true
    
    @IBOutlet weak var btnGuardar: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnGuardar.layer.cornerRadius = 6
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDesayuno(_ sender: UIButton) {
        if desayuno {
            sender.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
            desayuno = false
        }else{
            sender.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            desayuno = true
        }
    }
    
    @IBAction func btnComida(_ sender: UIButton) {
        if comida {
            sender.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
            comida = false
        }else{
            sender.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            comida = true
        }
    }
    
    @IBAction func btnCena(_ sender: UIButton) {
        if cena {
            sender.setImage(UIImage(named:"p8_checkV.png"), for: UIControl.State())
            cena = false
        }else{
            sender.setImage(UIImage(named:"p8_checkB.png"), for: UIControl.State())
            cena = true
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
