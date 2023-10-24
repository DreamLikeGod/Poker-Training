//
//  SettingsViewController.swift
//  Poker
//
//  Created by Егор on 22.10.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    let data = Settings.shared
    
    var back = UIColor.black
    var stage = 0
    
    @IBOutlet weak var colorBlue: UIView!
    @IBOutlet weak var colorGreen: UIView!
    @IBOutlet weak var colorWine: UIView!
    
    @IBOutlet weak var bluePicker: UISwitch!
    @IBOutlet weak var greenPicker: UISwitch!
    @IBOutlet weak var winePicker: UISwitch!
    
    @IBOutlet weak var firstStage: UISwitch!
    @IBOutlet weak var firstTshirt: UIImageView!
    @IBOutlet weak var firstFace: UIImageView!
    
    @IBOutlet weak var secondStage: UISwitch!
    @IBOutlet weak var secondTshirt: UIImageView!
    @IBOutlet weak var secondFace: UIImageView!
    
    @IBOutlet weak var thirdStage: UISwitch!
    @IBOutlet weak var thirdTshirt: UIImageView!
    @IBOutlet weak var thirdFace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stage = data.getData().0
        back = data.getData().1
        
        switch stage {
        case 0:
            firstStage.isOn = true
            secondStage.isOn = false
            thirdStage.isOn = false
        case 1:
            firstStage.isOn = false
            secondStage.isOn = true
            thirdStage.isOn = false
        case 2:
            firstStage.isOn = false
            secondStage.isOn = false
            thirdStage.isOn = true
        default:
            firstStage.isOn = true
            secondStage.isOn = false
            thirdStage.isOn = false
        }
        
        switch back {
        case UIColor(named: "blue")!:
            bluePicker.isOn = true
            greenPicker.isOn = false
            winePicker.isOn = false
        case UIColor(named: "green")!:
            bluePicker.isOn = false
            greenPicker.isOn = true
            winePicker.isOn = false
        case UIColor(named: "wine")!:
            bluePicker.isOn = false
            greenPicker.isOn = false
            winePicker.isOn = true
        default:
            bluePicker.isOn = true
            greenPicker.isOn = false
            winePicker.isOn = false
        }
        
        self.firstTshirt.image = UIImage(named: "0Closed")
        self.firstFace.image = UIImage(named: "0AceOfDiamonds")
        self.secondTshirt.image = UIImage(named: "1Closed")
        self.secondFace.image = UIImage(named: "1AceOfDiamonds")
        self.thirdTshirt.image = UIImage(named: "2Closed")
        self.thirdFace.image = UIImage(named: "2AceOfDiamonds")

        self.colorBlue.layer.borderWidth = 2.5
        self.colorBlue.layer.borderColor = UIColor.black.cgColor
        self.colorGreen.layer.borderWidth = 2.5
        self.colorGreen.layer.borderColor = UIColor.black.cgColor
        self.colorWine.layer.borderWidth = 2.5
        self.colorWine.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func firstStage(_ sender: Any) {
        secondStage.isOn = false
        thirdStage.isOn = false
        stage = 0
    }
    @IBAction func secondStage(_ sender: Any) {
        firstStage.isOn = false
        thirdStage.isOn = false
        stage = 1
    }
    @IBAction func thirdStage(_ sender: Any) {
        firstStage.isOn = false
        secondStage.isOn = false
        stage = 2
    }
    
    @IBAction func bluePicker(_ sender: Any) {
        greenPicker.isOn = false
        winePicker.isOn = false
        back = UIColor(named: "blue") ?? .black
    }
    @IBAction func greenPicker(_ sender: Any) {
        bluePicker.isOn = false
        winePicker.isOn = false
        back = UIColor(named: "green") ?? .black
    }
    @IBAction func winePicker(_ sender: Any) {
        bluePicker.isOn = false
        greenPicker.isOn = false
        back = UIColor(named: "wine") ?? .black
    }
    
    @IBAction func btnSave(_ sender: Any) {
        data.saveData(withCards: stage, andBackground: back)
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
