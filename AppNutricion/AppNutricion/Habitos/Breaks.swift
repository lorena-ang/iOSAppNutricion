//
//  Breaks.swift
//  AppNutricion
//
//  Created by Chut on 02/11/21.
//

import UIKit

class Breaks: Codable {
    var tiempo : String!
    var hora : String!
    
    init(tiempo : String, hora : String) {
        self.tiempo = tiempo
        self.hora = hora
    }


}
