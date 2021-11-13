//
//  Agua.swift
//  AppNutricion
//
//  Created by Estefy Charles on 13/10/21.
//

import UIKit

class Agua: Codable {
    var vaso : Int!
    var fecha: DateComponents
    
    init(vaso : Int, fecha:DateComponents) {
        self.vaso = vaso
        self.fecha = fecha
    }

}
