//
//  Celular.swift
//  AppNutricion
//
//  Created by Estefy Charles on 30/10/21.
//

import UIKit

class Celular: Codable {
    var id : Int!
    var hora : String!
    var hrsSin : Int!
    var fecha : DateComponents
    
    init(id : Int, hora : String, hrsSin : Int, fecha : DateComponents) {
        self.id = id
        self.hora = hora
        self.hrsSin = hrsSin
        self.fecha = fecha
    }
}
