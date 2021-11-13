//
//  Pasos.swift
//  AppNutricion
//
//  Created by Estefy Charles on 14/10/21.
//

import UIKit

class Pasos: Codable {
    var pasos : Int!
    var fecha: DateComponents
    
    init(pasos: Int, fecha:DateComponents) {
        self.pasos = pasos
        self.fecha = fecha
    }

}
