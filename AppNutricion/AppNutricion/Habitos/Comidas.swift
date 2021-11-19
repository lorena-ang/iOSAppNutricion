//
//  Comidas.swift
//  AppNutricion
//
//  Created by Estefy Charles on 13/10/21.
//

import UIKit

class Comidas: Codable {
    var id: Int!
    var desayuno: Bool
    var comida: Bool
    var cena: Bool
    var fecha: DateComponents
    
    init(id:Int, desayuno:Bool,comida:Bool,cena:Bool,fecha:DateComponents) {
        self.id = id
        self.desayuno = desayuno
        self.comida = comida
        self.cena = cena
        self.fecha = fecha
    }
    
}
