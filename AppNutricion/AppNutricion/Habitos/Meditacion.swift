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
    var fecha: DateComponents
    
    init(tiempo : String, hora : String, check : String, fecha:DateComponents) {
        self.tiempo = tiempo
        self.hora = hora
        self.check = check
        self.fecha = fecha
    }

}
