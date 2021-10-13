//
//  ViewControllerMeditacion.swift
//  AppNutricion
//
//  Created by Chut on 13/10/21.
//

import UIKit

class ViewControllerMeditacion: UIViewController {

    @IBOutlet weak var btnGuardar: UIButton!
    @IBOutlet weak var btnIniciar: UIButton!
    @IBOutlet weak var lbCronometro: UILabel!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnGuardar.layer.cornerRadius = 6
        btnIniciar.layer.cornerRadius = 6

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnStart(_ sender: UIButton) {
        if(timerCounting){
            timerCounting = false
            timer.invalidate()
            btnIniciar.setTitle("Iniciar", for: .normal)
        }else{
            timerCounting = true
            btnIniciar.setTitle("Detener", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimerString(hours: time.0, minutes: time.1, seconds: time.2)
        lbCronometro.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds:Int) -> (Int,Int,Int){
        return (seconds / 3600, (seconds % 3600)/60, ((seconds % 3600)%60))
    }
    
    func makeTimerString(hours: Int, minutes: Int, seconds: Int) -> String{
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
