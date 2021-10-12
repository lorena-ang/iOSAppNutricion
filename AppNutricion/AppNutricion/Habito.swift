//
//  Habito.swift
//  AppNutricion
//
//  Created by Lore Ang on 11/10/21.
//

import UIKit

class Habito: NSObject {

    var id: Int
    var nombre: String
    var imgHabito: UIImage
    
    init(id: Int, nombre: String, imgHabito: UIImage) {
        self.id = id
        self.nombre = nombre
        self.imgHabito = imgHabito
    }
}
