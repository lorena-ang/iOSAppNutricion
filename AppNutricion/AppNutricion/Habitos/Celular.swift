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
    
    init(id : Int, hora : String, hrsSin : Int) {
        self.id = id
        self.hora = hora
        self.hrsSin = hrsSin
    }
}
