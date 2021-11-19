//
//  Ejercicio.swift
//  AppNutricion
//
//  Created by Chut on 30/10/21.
//

import UIKit

class Ejercicio: Codable {
    var id : Int!
    var hora : String!
    var check: String!
    var fecha: DateComponents
    
    init(id: Int, hora : String, check : String, fecha:DateComponents) {
        self.id = id
        self.hora = hora
        self.check = check
        self.fecha = fecha
    }
}

