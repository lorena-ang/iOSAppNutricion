//
//  SeleccionCollectionView.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class SeleccionCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var habitosSeleccionados = [Habito]()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! SeleccionCollectionViewCell
        
        cell.setHabito(label: habitosSeleccionados[indexPath.row].nombre, img: habitosSeleccionados[indexPath.row].imgHabito)
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitosSeleccionados.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    // Tamaño de celdas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 152, height: 158)
    }
    
    // Seleccionar celda
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SeleccionCollectionViewCell {
            cell.layer.cornerRadius = 5.0
            cell.backgroundColor = UIColor(red: 131/255, green: 60/255, blue: 223/255, alpha: 0.06)
        }
    }
    
    // Deseleccionar celda
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SeleccionCollectionViewCell {
            cell.backgroundColor = UIColor.white
        }
    }
}

