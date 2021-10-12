//
//  SeleccionCollectionView.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class SeleccionCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! SeleccionCollectionViewCell
        
        cell.setHabito(label: listaHabitos[indexPath.row].nombre, img: listaHabitos[indexPath.row].imgHabito)
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaHabitos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    // Tamaño de celdas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 152, height: 158)
    }
    
    // Seleccionar celdas
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SeleccionCollectionViewCell {
            cell.layer.cornerRadius = 5.0
            cell.backgroundColor = UIColor(red: 131/255, green: 60/255, blue: 223/255, alpha: 0.06)
            let selected = listaHabitos[indexPath.item]
            habitosSeleccionados.append(selected)
        }
    }
    
    // Deseleccionar celdas y almacenar indices
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SeleccionCollectionViewCell {
            cell.backgroundColor = UIColor.white
            if let indexValue = habitosSeleccionados.firstIndex(of: listaHabitos[indexPath.item]) {
                habitosSeleccionados.remove(at: indexValue)
            }
        }
    }
}

