//
//  Celular.swift
//  AppNutricion
//
//  Created by Estefy Charles on 30/10/21.
//

import UIKit

class Celular: Codable {
    var hora : String!
    var hrsSin : Int!
    
    init(hora : String, hrsSin : Int) {
        self.hora = hora
        self.hrsSin = hrsSin
    }
}
