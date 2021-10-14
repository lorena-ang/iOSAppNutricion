//
//  Comidas.swift
//  AppNutricion
//
//  Created by Estefy Charles on 13/10/21.
//

import UIKit

class Comidas: Codable {
    var desayuno: Bool
    var comida: Bool
    var cena: Bool
    
    init(desayuno:Bool,comida:Bool,cena:Bool) {
        self.desayuno = desayuno
        self.comida = comida
        self.cena = cena
    }
    
}
