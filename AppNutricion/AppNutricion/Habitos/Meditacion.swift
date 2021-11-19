//
//  Meditacion.swift
//  AppNutricion
//
//  Created by Estefy Charles on 14/10/21.
//

import UIKit

class Meditacion: Codable {
    var id : Int!
    var tiempo : String!
    var hora : String!
    var check: String!
    var fecha: DateComponents
    
    init(id : Int, tiempo : String, hora : String, check : String, fecha:DateComponents) {
        self.id = id
        self.tiempo = tiempo
        self.hora = hora
        self.check = check
        self.fecha = fecha
    }

}
