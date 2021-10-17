//
//  SeleccionCollectionView.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class SeleccionCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var habitosSeleccionados = [Habito]()
    var viewControllerPadre: ViewControllerPaginaPrincipal!
    
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
            // Hacer que se ejecute el segue dependiendo de la celda seleccionada
            var identifier: String!
            let id = habitosSeleccionados[indexPath.item].id
            switch id {
            case 1:
                identifier = "segEjercicio"
            case 2:
                identifier = "segSinCelular"
            case 3:
                identifier = "segComidas"
            case 4:
                identifier = "segBreaks"
            case 5:
                identifier = "segRaciones"
            case 6:
                identifier = "segMeditacion"
            case 7:
                identifier = "segVasos"
            case 8:
                identifier = "segSueno"
            case 9:
                identifier = "segPasos"
            default:
                identifier = "nada"
            }
            viewControllerPadre.ejecutarSegue(identifier: identifier)
        }
    }
}

