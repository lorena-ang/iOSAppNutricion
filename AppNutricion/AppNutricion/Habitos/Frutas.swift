//
//  Frutas.swift
//  AppNutricion
//
//  Created by Estefy Charles on 13/10/21.
//

import UIKit

class Frutas: Codable {
    var fruta : Int
    var verdura : Int
    var fecha: DateComponents
    
    init(fruta:Int,verdura:Int, fecha:DateComponents) {
        self.fruta = fruta
        self.verdura = verdura
        self.fecha = fecha
    }

}
