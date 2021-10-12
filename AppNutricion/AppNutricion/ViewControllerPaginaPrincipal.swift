//
//  ViewControllerPaginaPrincipal.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class ViewControllerPaginaPrincipal: UIViewController {

    @IBOutlet weak var collectionView: SeleccionCollectionView!
    var listaHabitos = [
        Habito(id: 1, nombre: "Rutina de ejercicio", imgHabito: UIImage(named: "ejercicio")!),
        Habito(id: 2, nombre: "Horas antes de dormir sin celular", imgHabito: UIImage(named: "celular")!),
        Habito(id: 3, nombre: "Comidas completas", imgHabito: UIImage(named: "comidas")!),
        Habito(id: 4, nombre: "Breaks de actividades", imgHabito: UIImage(named: "breaks")!),
        Habito(id: 5, nombre: "Raciones de frutas y verduras", imgHabito: UIImage(named: "raciones")!),
        Habito(id: 6, nombre: "Minutos de meditación", imgHabito: UIImage(named: "meditacion")!),
        Habito(id: 7, nombre: "Vasos de agua", imgHabito: UIImage(named: "agua")!),
        Habito(id: 8, nombre: "Horas de sueño", imgHabito: UIImage(named: "sueno")!),
        Habito(id: 9, nombre: "Mil pasos", imgHabito: UIImage(named: "pasos")!)
    ]
    var habitosSeleccionados = [Habito]()
    
    @IBOutlet weak var btnAgregar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAgregar.layer.cornerRadius = 5
        // Este solo es un parche para que puedan hacer las otras funcionalidades en lo que logro hacer que habitosSeleccionados se actualice desde TabBarController
        collectionView.habitosSeleccionados = listaHabitos
        // Do any additional setup after loading the view.
    }
}
