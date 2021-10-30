//
//  Ejercicio.swift
//  AppNutricion
//
//  Created by Chut on 30/10/21.
//

import UIKit

class Ejercicio: Codable {
    var hora : String!
    var check: String!
    
    init(hora : String, check : String) {
        self.hora = hora
        self.check = check
    }
}

