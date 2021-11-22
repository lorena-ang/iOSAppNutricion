//
//  ViewControllerPaginaPrincipal.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class ViewControllerPaginaPrincipal: UIViewController {
    
    @IBOutlet weak var collectionView: SeleccionCollectionView!
    @IBOutlet weak var btnAgregar: UIButton!
    
    var habitosSeleccionados = [Habito]()
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
    var habitoIds = [Any]()
    var identifier: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAgregar.layer.cornerRadius = 5
        collectionView.viewControllerPadre = self
        collectionView.allowsMultipleSelection = false
        obtenerHabitos()
        collectionView.habitosSeleccionados = habitosSeleccionados
    }
    
    // Obtener hábitos de UserDefaults
    func obtenerHabitos() {
        habitoIds.removeAll()
        let defaults = UserDefaults.standard
        habitoIds = defaults.array(forKey: "habitoIds") as? [Int] ?? [Int]()
        for id in habitoIds {
            for habito in listaHabitos {
                if habito.id == id as! Int {
                    habitosSeleccionados.append(habito)
                }
            }
        }
    }
    
    func actualizarHabitos() {
        // Ordenar hábitos por id
        habitosSeleccionados.sort { (h1, h2) in
            h1.id < h2.id
        }
        // Almacenar ids de hábitos seleccionados en userDefaults
        habitoIds.removeAll()
        for habito in habitosSeleccionados {
            habitoIds.append(habito.id)
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(habitoIds, forKey: "habitoIds")
    }
    
    // Segues de hábitos
    func ejecutarSegue(identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    // MARK: - Navigation
    // Segue de selección
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segSeleccion" {
            let vistaSeleccion = segue.destination as! ViewControllerSeleccion
            vistaSeleccion.habitosSeleccionados = habitosSeleccionados
        }
    }
    
    @IBAction func unwindGuardarSeleccion(unwindSegue: UIStoryboardSegue) {
        if let sourceVC = unwindSegue.source as? ViewControllerSeleccion {
            habitosSeleccionados = sourceVC.collectionView.habitosSeleccionados
            actualizarHabitos()
            collectionView.habitosSeleccionados = habitosSeleccionados
            collectionView.reloadData()
        }
    }
    
    // MARK: - Limitar orientación a portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
