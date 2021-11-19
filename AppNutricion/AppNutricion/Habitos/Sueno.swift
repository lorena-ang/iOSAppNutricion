//
//  Sueno.swift
//  AppNutricion
//
//  Created by Chut on 29/10/21.
//

import UIKit

class Sueno: Codable {
    var id : Int!
    var horaDespertar : String!
    var horaDormir : String!
    var fecha : DateComponents
    
    init(id : Int, horaDespertar : String, horaDormir : String, fecha : DateComponents) {
        self.id = id
        self.horaDespertar = horaDespertar
        self.horaDormir = horaDormir
        self.fecha = fecha
    }

}
