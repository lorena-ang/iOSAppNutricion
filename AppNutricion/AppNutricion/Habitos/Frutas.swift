//
//  Frutas.swift
//  AppNutricion
//
//  Created by Estefy Charles on 13/10/21.
//

import UIKit

class Frutas: Codable {
    var id : Int!
    var fruta : Int
    var verdura : Int
    var fecha: DateComponents
    
    init(id:Int,fruta:Int,verdura:Int, fecha:DateComponents) {
        self.id = id
        self.fruta = fruta
        self.verdura = verdura
        self.fecha = fecha
    }

}
