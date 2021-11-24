//
//  ViewControllerPerfil.swift
//  AppNutricion
//
//  Created by Lore Ang on 12/10/21.
//

import UIKit

class ViewControllerPerfil: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
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
    var ejercicioActual = Ejercicio(id: 1, hora: "00:00", check: "false", fecha: .init(year:1900, month: 1, day: 1))
    var celularActual = Celular(id: 2, hora: "0", hrsSin: 0, completado: false, fecha: .init(year:1900, month: 1, day: 1))
    var comidasActual = Comidas(id: 3, desayuno: false, comida: false, cena: false, fecha: .init(year:1900, month: 1, day: 1))
    var breaksActual = Breaks(id: 4, cantidad: "0", cadaCuanto: "00:00", duracion: "0", completado: false, fecha: .init(year:1900, month: 1, day: 1))
    var frutasActual = Frutas(id: 5, fruta: 0, verdura:0, fecha: .init(year:1900, month: 1, day: 1))
    var meditacionActual = Meditacion(id: 6, tiempo: "00 : 00 : 00", hora: "00:00", check: "false", fecha: .init(year:1900, month: 1, day: 1))
    var aguaActual = Agua(id: 7, vaso: 0, fecha: .init(year:1900, month: 1, day: 1))
    var suenoActual = Sueno(id: 8, horaDespertar: "00:00", horaDormir: "00:00", completado: false, fecha: .init(year:1900, month: 1, day: 1))
    var pasosActual = Pasos(id: 9, pasos: 0, fecha: .init(year:1900, month: 1, day: 1))
    var habitoIds = [Any]()
    var habitoNombres = [String]()
    var habitoNumAtributos = [Int]()
    var mostrarId = [Int]()
    var nombre: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfNombre.layer.cornerRadius = 5
        let defaults = UserDefaults.standard
        nombre = defaults.value(forKey: "nombre") as! String
        tfNombre.text = nombre
        print(habitoIds)
        obtenerHabitos()
        print(habitoIds)
    }

    @IBAction func quitateclado() {
        view.endEditing(true)
        let nuevoNombre = tfNombre.text
        // Actualizar cambio en UserDefaults si hubo
        if nombre != nuevoNombre {
            let defaults = UserDefaults.standard
            defaults.setValue(tfNombre.text, forKey: "nombre")
        }
    }
    
    // Obtener hábitos de UserDefaults
    func obtenerHabitos() {
        habitoIds.removeAll()
        habitosSeleccionados.removeAll()
        let defaults = UserDefaults.standard
        habitoIds = defaults.array(forKey: "habitoIds") as? [Int] ?? [Int]()
        for id in habitoIds {
            obtenerProgresoHabito(habito: (id as! Int))
            for habito in listaHabitos {
                if habito.id == id as! Int {
                    habitosSeleccionados.append(habito)
                }
            }
        }
        obtenerNombres();
        obtenerIds();
        obtenerNumAtributos()
    }
    
    // Obtener nombres de hábitos
    func obtenerNombres() {
        habitoNombres.removeAll()
        for habito in listaHabitos {
            habitoNombres.append(habito.nombre)
        }
    }
    
    // Obtener ids de hábitos
    func obtenerIds() {
        mostrarId.removeAll()
        for habito in habitosSeleccionados {
            mostrarId.append(habito.id - 1)
        }
    }
    
    
    // Obtener cantidad de datos por hábito
    func obtenerNumAtributos() {
        habitoNumAtributos = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        for habito in habitosSeleccionados {
            switch habito.id {
                case 1:
                    // Ejercicio
                    habitoNumAtributos[0] = 2
                case 2:
                    // Celular
                    habitoNumAtributos[1] = 2
                case 3:
                    // Comidas
                    habitoNumAtributos[2] = 3
                case 4:
                    // Breaks
                    habitoNumAtributos[3] = 2
                case 5:
                    // Frutas
                    habitoNumAtributos[4] = 2
                case 6:
                    // Meditacion
                    habitoNumAtributos[5] = 2
                case 7:
                    // Agua
                    habitoNumAtributos[6] = 1
                case 8:
                    // Sueno
                    habitoNumAtributos[7] = 2
                case 9:
                    // Pasos
                    habitoNumAtributos[8] = 1
                default:
                    habitoNumAtributos[8] = 0
            }
        }
    }
    
    // MARK: - Obtener datos de hábitos Codable
    
    func dataFileURL(habito: String) -> URL {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let pathArchivo = documentsDirectory.appendingPathComponent(habito).appendingPathExtension("plist")
            return pathArchivo
    }
    
    func obtenerProgresoHabito(habito: Int) {
        switch habito {
        case 1:
            var listaTemp = [Ejercicio]()
            do{
                let data = try Data.init(contentsOf: dataFileURL(habito: "Ejercicio"))
                listaTemp = try PropertyListDecoder().decode([Ejercicio].self, from: data)
                ejercicioActual = listaTemp[0]
            }
            catch{
                if mostrarId.contains(1) {
                    print("Error al cargar los datos del archivo para habito 1")
                }
            }
        case 2:
            var listaTemp = [Celular]()
            do{
                let data = try Data.init(contentsOf: dataFileURL(habito: "Celular"))
                listaTemp = try PropertyListDecoder().decode([Celular].self, from: data)
                celularActual = listaTemp[0]
            }
            catch{
                if mostrarId.contains(2) {
                    print("No se pudieron cargar los datos del archivo para habito 2")
                }
            }
        case 3:
            var listaTemp = [Comidas]()
            do{
                let data = try Data.init(contentsOf: dataFileURL(habito: "Comidas"))
                listaTemp = try PropertyListDecoder().decode([Comidas].self, from: data)
                comidasActual = listaTemp[0]
            }
            catch{
                if mostrarId.contains(3) {
                    print("No se pudieron cargar los datos del archivo para habito 3")
                }
            }
        case 4:
            var listaTemp = [Breaks]()
            do{
                let data = try Data.init(contentsOf: dataFileURL(habito: "Breaks"))
                listaTemp = try PropertyListDecoder().decode([Breaks].self, from: data)
                breaksActual = listaTemp[0]
            }
            catch{
                if mostrarId.contains(4) {
                    print("No se pudieron cargar los datos del archivo para habito 4")
                }
            }
        case 5:
            var listaTemp = [Frutas]()
            do{
                let data = try Data.init(contentsOf: dataFileURL(habito: "Frutas"))
                listaTemp = try PropertyListDecoder().decode([Frutas].self, from: data)
                frutasActual = listaTemp[0]
            }
            catch{
                if mostrarId.contains(5) {
                    print("No se pudieron cargar los datos del archivo para habito 5")
                }
            }
        case 6:
            var listaTemp = [Meditacion]()
            do{
                let data = try Data.init(contentsOf: dataFileURL(habito: "Meditacion"))
                listaTemp = try PropertyListDecoder().decode([Meditacion].self, from: data)
                meditacionActual = listaTemp[0]
            }
            catch{
                if mostrarId.contains(6) {
                    print("No se pudieron cargar los datos del archivo para habito 6")
                }
            }
        case 7:
            var listaTemp = [Agua]()
            do{
                let data = try Data.init(contentsOf: dataFileURL(habito: "Agua"))
                listaTemp = try PropertyListDecoder().decode([Agua].self, from: data)
                aguaActual = listaTemp[0]
            }
            catch{
                if mostrarId.contains(7) {
                    print("No se pudieron cargar los datos del archivo para habito 7")
                }
            }
        case 8:
            var listaTemp = [Sueno]()
            do{
                let data = try Data.init(contentsOf: dataFileURL(habito: "Sueno"))
                listaTemp = try PropertyListDecoder().decode([Sueno].self, from: data)
                suenoActual = listaTemp[0]
            }
            catch{
                if mostrarId.contains(8) {
                    print("No se pudieron cargar los datos del archivo para habito 8")
                }
            }
        case 9:
            var listaTemp = [Pasos]()
            do{
                let data = try Data.init(contentsOf: dataFileURL(habito: "Pasos"))
                listaTemp = try PropertyListDecoder().decode([Pasos].self, from: data)
                pasosActual = listaTemp[0]
            }
            catch{
                if mostrarId.contains(9) {
                    print("No se pudieron cargar los datos del archivo para habito 9")
                }
            }
        default:
            print("No se encontraron datos para cargar de nada")
        }
    }
    
    // MARK: - Métodos de data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (!mostrarId.contains(section)) {
            return 0.0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let nombreSec: String
        switch section {
            case 0:
                nombreSec = habitoNombres[0]
            case 1:
                nombreSec = habitoNombres[1]
            case 2:
                nombreSec = habitoNombres[2]
            case 3:
                nombreSec = habitoNombres[3]
            case 4:
                nombreSec = habitoNombres[4]
            case 5:
                nombreSec = habitoNombres[5]
            case 6:
                nombreSec = habitoNombres[6]
            case 7:
                nombreSec = habitoNombres[7]
            case 8:
                nombreSec = habitoNombres[8]
            default:
                nombreSec = "No hay datos para mostrar"
        }
        return nombreSec
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // Color de fondo de header
        view.tintColor = UIColor(red: 142/255, green: 89/255, blue: 227/255, alpha: 1)
        // Color de letra de header
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows: Int
        switch section {
            case 0:
                rows = habitoNumAtributos[0]
            case 1:
                rows = habitoNumAtributos[1]
            case 2:
                rows = habitoNumAtributos[2]
            case 3:
                rows = habitoNumAtributos[3]
            case 4:
                rows = habitoNumAtributos[4]
            case 5:
                rows = habitoNumAtributos[5]
            case 6:
                rows = habitoNumAtributos[6]
            case 7:
                rows = habitoNumAtributos[7]
            case 8:
                rows = habitoNumAtributos[8]
            default:
                rows = 0
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        switch indexPath.section {
            case 0:
                // Ejercicio
                if indexPath.row == 0 {
                    if (ejercicioActual.hora == "") {
                        cell.textLabel?.text = "Tiempo invertido: 0 hr 0 min"
                    }
                    else {
                        let ej = ejercicioActual.hora!
                        let startIndex = ej.index(ej.startIndex, offsetBy: 0)
                        let endIndex = ej.index(ej.startIndex, offsetBy: 1)
                        let startIndex2 = ej.index(ej.startIndex, offsetBy: 3)
                        let endIndex2 = ej.index(ej.startIndex, offsetBy: 4)
                        cell.textLabel?.text = "Tiempo invertido: " + ej[startIndex...endIndex] + " hr " + ej[startIndex2...endIndex2] + " min"
                    }
                }
                else {
                    cell.textLabel?.text = "Estatus: " + (ejercicioActual.check == "true" ? "Completado" : "No completado")
                }
                if (ejercicioActual.check == "false" && ejercicioActual.hora == "") {
                    cell.backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 252/255, alpha: 1)
                }
                else {
                    cell.backgroundColor = UIColor.white
                }
            case 1:
                // Celular
                if indexPath.row == 0 {
                    cell.textLabel?.text = (celularActual.completado ? "Recordatorio calendarizado" : "No hay recordatorios")
                }
                else {
                    cell.textLabel?.text = "Horas antes de dormir sin celular: " + (celularActual.hrsSin != 0 ? String(celularActual.hrsSin) + " hr" : "ninguna")
                }
                if (!celularActual.completado) {
                    cell.backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 252/255, alpha: 1)
                }
                else {
                    cell.backgroundColor = UIColor.white
                }
            case 2:
                // Comidas
                if indexPath.row == 0 {
                    cell.textLabel?.text = "Desayuno: " + (comidasActual.desayuno ? "Completado" : "No completado")
                }
                else if indexPath.row == 1 {
                    cell.textLabel?.text = "Comida: " + (comidasActual.comida ? "Completada" : "No completada")
                }
                else {
                    cell.textLabel?.text = "Cena: " + (comidasActual.cena ? "Completada" : "No completada")
                }
                if (comidasActual.desayuno == false && comidasActual.comida == false && comidasActual.cena == false) {
                    cell.backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 252/255, alpha: 1)
                }
                else {
                    cell.backgroundColor = UIColor.white
                }
            case 3:
                // Breaks
                if indexPath.row == 0 {
                    cell.textLabel?.text = (breaksActual.completado ? "Recordatorio calendarizado" : "No hay recordatorios")
                }
                else {
                    cell.textLabel?.text = "Breaks programados: " + (breaksActual.cantidad != "0" ? breaksActual.cantidad + " breaks" : "ninguno")
                }
                if (!breaksActual.completado) {
                    cell.backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 252/255, alpha: 1)
                }
                else {
                    cell.backgroundColor = UIColor.white
                }
            case 4:
                // Frutas
                if indexPath.row == 0 {
                    cell.textLabel?.text = "Raciones de frutas: " + String(frutasActual.fruta)
                }
                else {
                    cell.textLabel?.text = "Raciones de verduras: " + String(frutasActual.verdura)
                }
                if (frutasActual.fruta == 0 && frutasActual.verdura == 0) {
                    cell.backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 252/255, alpha: 1)
                }
                else {
                    cell.backgroundColor = UIColor.white
                }
            case 5:
                // Meditacion
                if indexPath.row == 0 {
                    let med = meditacionActual.hora!
                    let startIndex = med.index(med.startIndex, offsetBy: 0)
                    let endIndex = med.index(med.startIndex, offsetBy: 1)
                    let startIndex2 = med.index(med.startIndex, offsetBy: 3)
                    let endIndex2 = med.index(med.startIndex, offsetBy: 4)
                    cell.textLabel?.text = "Tiempo invertido: " + med[startIndex...endIndex] + " hr " + med[startIndex2...endIndex2] + " min"
                }
                else {
                    cell.textLabel?.text = "Estatus: " + (meditacionActual.check == "true" ? "Completado" : "No completado")
                }
                if (meditacionActual.check == "false" && meditacionActual.hora == "00:00") {
                    cell.backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 252/255, alpha: 1)
                }
                else {
                    cell.backgroundColor = UIColor.white
                }
            case 6:
                // Agua
                cell.textLabel?.text = "Vasos de agua: " + String(aguaActual.vaso)
                if (aguaActual.vaso == 0) {
                    cell.backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 252/255, alpha: 1)
                }
                else {
                    cell.backgroundColor = UIColor.white
                }
            case 7:
                // Sueno
                if indexPath.row == 0 {
                    cell.textLabel?.text = (suenoActual.completado ? "Recordatorio calendarizado" : "No hay recordatorios")
                }
                else {
                    cell.textLabel?.text = "Hora de dormir: " + (suenoActual.completado ? suenoActual.horaDormir : "ninguna")
                }
                if (!suenoActual.completado) {
                    cell.backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 252/255, alpha: 1)
                }
                else {
                    cell.backgroundColor = UIColor.white
                }
            case 8:
                // Pasos
                cell.textLabel?.text = "Pasos: " + String(pasosActual.pasos)
                if (pasosActual.pasos == 0) {
                    cell.backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 252/255, alpha: 1)
                }
                else {
                    cell.backgroundColor = UIColor.white
                }
            default:
                habitoNumAtributos.append(0)
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        obtenerHabitos()
        tableView.reloadData()
    }
    
    // MARK: - Limitar orientación a portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
