//
//  CustomCollectionViewCell.swift
//  AppNutricion
//
//  Created by Lore Ang on 11/10/21.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgHabito: UIImageView!
    @IBOutlet weak var lbHabito: UILabel!
    
    func setHabito(label:String, img:UIImage) {
        lbHabito.layer.masksToBounds = true
        lbHabito.layer.cornerRadius = 5
        lbHabito.text = label
        imgHabito.image = img
    }
}
