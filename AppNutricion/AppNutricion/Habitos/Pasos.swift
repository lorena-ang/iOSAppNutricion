//
//  Pasos.swift
//  AppNutricion
//
//  Created by Estefy Charles on 14/10/21.
//

import UIKit

class Pasos: Codable {
    var id : Int!
    var pasos : Int!
    var fecha: DateComponents
    
    init(id: Int, pasos: Int, fecha:DateComponents) {
        self.id = id
        self.pasos = pasos
        self.fecha = fecha
    }

}
