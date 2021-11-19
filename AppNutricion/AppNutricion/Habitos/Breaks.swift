//
//  Breaks.swift
//  AppNutricion
//
//  Created by Chut on 02/11/21.
//

import UIKit

class Breaks: Codable {
    var id : Int!
    var cantidad : String!
    var cadaCuanto : String!
    var duracion : String!
    var fecha : DateComponents
    
    init(id : Int, cantidad : String, cadaCuanto : String, duracion : String, fecha : DateComponents) {
        self.id = id
        self.cantidad = cantidad
        self.cadaCuanto = cadaCuanto
        self.duracion = duracion
        self.fecha = fecha
    }
}
