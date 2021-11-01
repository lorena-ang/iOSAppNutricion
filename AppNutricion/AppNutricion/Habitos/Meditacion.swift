//
//  Meditacion.swift
//  AppNutricion
//
//  Created by Estefy Charles on 14/10/21.
//

import UIKit

class Meditacion: Codable {
    var tiempo : String!
    var hora : String!
    var check: String!
    
    init(tiempo : String, hora : String, check : String) {
        self.tiempo = tiempo
        self.hora = hora
        self.check = check
    }

}
