//
//  ViewControllerAgua.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class ViewControllerAgua: UIViewController {
    
    @IBOutlet weak var imgVaso1: UIImageView!
    @IBOutlet weak var imgVaso2: UIImageView!
    @IBOutlet weak var imgVaso3: UIImageView!
    @IBOutlet weak var imgVaso4: UIImageView!
    @IBOutlet weak var imgVaso5: UIImageView!
    @IBOutlet weak var imgVaso6: UIImageView!
    @IBOutlet weak var imgVaso7: UIImageView!
    @IBOutlet weak var imgVaso8: UIImageView!
    @IBOutlet weak var lbCantVasos: UILabel!
    @IBOutlet weak var btnGuardar: UIButton!
    
    var numVaso = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnGuardar.layer.cornerRadius = 6

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnMas(_ sender: UIButton) {
        numVaso+=1
            if numVaso == 1 {
                imgVaso1.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("7")
            }else if numVaso == 2{
                imgVaso2.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("6")
            }else if numVaso == 3{
                imgVaso3.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("5")
            }else if numVaso == 4{
                imgVaso4.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("4")
            }else if numVaso == 5{
                imgVaso5.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("3")
            }else if numVaso == 6{
                imgVaso6.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("2")
            }else if numVaso == 7{
                imgVaso7.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("1")
            }else if numVaso == 8{
                imgVaso8.image = UIImage(named: "p12_vaso.png")
                lbCantVasos.text = String("0")
            }else if numVaso >= 9 {
                numVaso = 8
            }
    }
    
    @IBAction func btnMenos(_ sender: UIButton) {
        if numVaso == 1 {
            imgVaso1.image = UIImage(named: "")
            lbCantVasos.text = String("8")
        }else if numVaso == 2{
            imgVaso2.image = UIImage(named: "")
            lbCantVasos.text = String("7")
        }else if numVaso == 3{
            imgVaso3.image = UIImage(named: "")
            lbCantVasos.text = String("6")
        }else if numVaso == 4{
            imgVaso4.image = UIImage(named: "")
            lbCantVasos.text = String("5")
        }else if numVaso == 5{
            imgVaso5.image = UIImage(named: "")
            lbCantVasos.text = String("4")
        }else if numVaso == 6{
            imgVaso6.image = UIImage(named: "")
            lbCantVasos.text = String("3")
        }else if numVaso == 7{
            imgVaso7.image = UIImage(named: "")
            lbCantVasos.text = String("2")
        }else if numVaso == 8{
            imgVaso8.image = UIImage(named: "")
            lbCantVasos.text = String("1")
        }
        if numVaso <= 0{
            numVaso = 0
        }else{
            numVaso-=1
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
