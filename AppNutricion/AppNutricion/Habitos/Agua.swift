//
//  Agua.swift
//  AppNutricion
//
//  Created by Estefy Charles on 13/10/21.
//

import UIKit

class Agua: Codable {
    var id : Int!
    var vaso : Int!
    var fecha: DateComponents
    
    init(id:Int, vaso:Int, fecha:DateComponents) {
        self.id = id
        self.vaso = vaso
        self.fecha = fecha
    }

}
