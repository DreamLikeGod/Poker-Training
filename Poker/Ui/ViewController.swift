//
//  ViewController.swift
//  Poker
//
//  Created by Егор on 02.04.2023.
//

import UIKit

class ViewController: UIViewController {

    var game = Game()
    
    //Setting value will SAVED
    var stage = 0
    var back = UIColor(named: "blue")
    
    //Game's value
    var result:[(String, Bool)] = []
    var playersImg: [[UIImageView]] = []
    var tableImg: [UIImageView] = []
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var colorBlue: UIView!
    @IBOutlet weak var colorGreen: UIView!
    @IBOutlet weak var colorWine: UIView!
    @IBOutlet weak var bluePicker: UISwitch!
    @IBOutlet weak var greenPicker: UISwitch!
    @IBOutlet weak var winePicker: UISwitch!
    
    
    @IBOutlet weak var firstCards: UIView!
    @IBOutlet weak var firstTshirt: UIImageView!
    @IBOutlet weak var firstFace: UIImageView!
    @IBOutlet weak var secondCards: UIView!
    @IBOutlet weak var secondTshirt: UIImageView!
    @IBOutlet weak var secondFace: UIImageView!
    @IBOutlet weak var thirdCards: UIView!
    @IBOutlet weak var thirdTshirt: UIImageView!
    @IBOutlet weak var thirdFace: UIImageView!
    @IBOutlet weak var firstStage: UISwitch!
    @IBOutlet weak var secondStage: UISwitch!
    @IBOutlet weak var thirdStage: UISwitch!
    
    @IBOutlet weak var firstWinner: UIButton!
    @IBOutlet weak var secondWinner: UIButton!
    @IBOutlet weak var thirdWinner: UIButton!
    
    @IBOutlet weak var labelPl1: UILabel!
    @IBOutlet weak var labelPl2: UILabel!
    @IBOutlet weak var labelPl3: UILabel!
    
    @IBOutlet weak var imgPl1c1: UIImageView!
    @IBOutlet weak var imgPl1c2: UIImageView!
    
    @IBOutlet weak var imgPl2c1: UIImageView!
    @IBOutlet weak var imgPl2c2: UIImageView!
    
    @IBOutlet weak var imgPl3c1: UIImageView!
    @IBOutlet weak var imgPl3c2: UIImageView!
    
    @IBOutlet weak var imgTblc1: UIImageView!
    @IBOutlet weak var imgTblc2: UIImageView!
    @IBOutlet weak var imgTblc3: UIImageView!
    @IBOutlet weak var imgTblc4: UIImageView!
    @IBOutlet weak var imgTblc5: UIImageView!
    
    @IBOutlet weak var textWinner: UILabel!
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnRules: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    @IBOutlet weak var btnMainExit: UIButton!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnExit: UIButton!
    
    func saveData(stage: Int, color: UIColor) {
        var colorVar = -1
        UserDefaults.standard.set(stage, forKey: "cards")
        switch color.cgColor {
        case UIColor(named: "blue")!.cgColor:
            colorVar = 0
        case UIColor(named: "green")!.cgColor:
            colorVar = 1
        case UIColor(named: "wine")!.cgColor:
            colorVar = 2
        default:
            fatalError("Не может быть другого цвета!!!")
        }
        UserDefaults.standard.set(colorVar, forKey: "color")
    }
    func getData() -> (Int, UIColor) {
        let def = UserDefaults.standard
        let stage = def.integer(forKey: "cards")
        let colorVar = def.integer(forKey: "color")
        switch colorVar {
        case 0:
            return (stage, UIColor(named: "blue")!)
        case 1:
            return (stage, UIColor(named: "green")!)
        case 2:
            return (stage, UIColor(named: "wine")!)
        default:
            return (stage, UIColor(named: "blue")!)
        }
    }
    
    func settingViewsHide() {
        btnStart.isHidden = !btnStart.isHidden
        btnSettings.isHidden = !btnSettings.isHidden
        btnRules.isHidden = !btnRules.isHidden
        btnMainExit.isHidden = !btnMainExit.isHidden
        
        firstCards.isHidden = !firstCards.isHidden
        secondCards.isHidden = !secondCards.isHidden
        thirdCards.isHidden = !thirdCards.isHidden
        
        firstStage.isHidden = !firstStage.isHidden
        secondStage.isHidden = !secondStage.isHidden
        thirdStage.isHidden = !thirdStage.isHidden
        
        colorBlue.isHidden = !colorBlue.isHidden
        colorGreen.isHidden = !colorGreen.isHidden
        colorWine.isHidden = !colorWine.isHidden
        
        bluePicker.isHidden = !bluePicker.isHidden
        greenPicker.isHidden = !greenPicker.isHidden
        winePicker.isHidden = !winePicker.isHidden
        
        textWinner.isHidden = !textWinner.isHidden
        textWinner.text = "Настройки"
        
        btnSave.isHidden = !btnSave.isHidden
    }
    
    func hiddenOff() {
        firstWinner.isHidden = !firstWinner.isHidden
        secondWinner.isHidden = !secondWinner.isHidden
        thirdWinner.isHidden = !thirdWinner.isHidden
        
        imgPl1c1.isHidden = !imgPl1c1.isHidden
        imgPl1c2.isHidden = !imgPl1c2.isHidden
        imgPl2c1.isHidden = !imgPl2c1.isHidden
        imgPl2c2.isHidden = !imgPl2c2.isHidden
        imgPl3c1.isHidden = !imgPl3c1.isHidden
        imgPl3c2.isHidden = !imgPl3c2.isHidden
        
        imgTblc1.isHidden = !imgTblc1.isHidden
        imgTblc2.isHidden = !imgTblc2.isHidden
        imgTblc3.isHidden = !imgTblc3.isHidden
        imgTblc4.isHidden = !imgTblc4.isHidden
        imgTblc5.isHidden = !imgTblc5.isHidden
        
        labelPl1.isHidden = !labelPl1.isHidden
        labelPl2.isHidden = !labelPl2.isHidden
        labelPl3.isHidden = !labelPl3.isHidden
        
        btnStart.isHidden = !btnStart.isHidden
        btnSettings.isHidden = !btnSettings.isHidden
        btnRules.isHidden = !btnRules.isHidden
        btnMainExit.isHidden = !btnMainExit.isHidden
        
        btnContinue.isHidden = !btnContinue.isHidden
        btnExit.isHidden = !btnExit.isHidden
        
        textWinner.isHidden = !textWinner.isHidden
    }
    
    func enabledBtn() {
        firstWinner.isEnabled = !firstWinner.isEnabled
        secondWinner.isEnabled = !secondWinner.isEnabled
        thirdWinner.isEnabled = !thirdWinner.isEnabled
        btnContinue.isEnabled = !btnContinue.isEnabled
    }
    
    func update() {
        game = Game()
        
        game.Players = game.PlayersInit(numberOfPlayers: 3)
        game.setPictCard(players: game.Players, pict: playersImg, stage: stage)
        
        game.table = game.contGame()
        game.setPictCardTable(table: game.table, pict: tableImg, stage: stage)
        
        result = game.winner(table: game.table, players: game.Players)
        result.shuffle()
        
        textWinner.text = "Кто выиграет?"
        textWinner.backgroundColor = .systemGray4
        
        firstWinner.setTitle(result[0].0, for: .normal)
        secondWinner.setTitle(result[1].0, for: .normal)
        thirdWinner.setTitle(result[2].0, for: .normal)
    }
    
    override func viewDidLoad() {
        self.playersImg = [[imgPl1c1,imgPl1c2],[imgPl2c1,imgPl2c2],[imgPl3c1,imgPl3c2]]
        self.tableImg = [imgTblc1,imgTblc2,imgTblc3,imgTblc4,imgTblc5]
        
        let data = getData()
        back = data.1
        stage = data.0
        
        self.mainView.backgroundColor = back
        
        self.firstCards.backgroundColor = .systemGray4
        self.secondCards.backgroundColor = .systemGray4
        self.thirdCards.backgroundColor = .systemGray4
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
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnStrtG(_ sender: UIButton) {
        update()
        
        hiddenOff()
        
        firstWinner.isEnabled = true
        secondWinner.isEnabled = true
        thirdWinner.isEnabled = true
        btnContinue.isEnabled = false
        btnExit.isEnabled = true
    }
    @IBAction func btnSettings(_ sender: Any) {
        switch mainView.backgroundColor!.cgColor {
        case UIColor(named: "blue")!.cgColor:
            bluePicker.isOn = true
        case UIColor(named: "green")!.cgColor:
            greenPicker.isOn = true
        case UIColor(named: "wine")!.cgColor:
            winePicker.isOn = true
        default:
            fatalError("Не может быть другого цвета!!!")
        }
        switch self.stage {
        case 0:
            firstStage.isOn = true
        case 1:
            secondStage.isOn = true
        case 2:
            thirdStage.isOn = true
        default:
            fatalError("Этого не может быть!!!")
        }
        self.mainView.backgroundColor = .systemGray4
        settingViewsHide()
    }
    @IBAction func btnExit(_ sender: Any) {
        exit(0)
    }
    
    @IBAction func firstStage(_ sender: Any) {
        secondStage.isOn = false
        thirdStage.isOn = false
    }
    @IBAction func secondStage(_ sender: Any) {
        firstStage.isOn = false
        thirdStage.isOn = false
    }
    @IBAction func thirdStage(_ sender: Any) {
        firstStage.isOn = false
        secondStage.isOn = false
    }
    @IBAction func bluePicker(_ sender: Any) {
        greenPicker.isOn = false
        winePicker.isOn = false
    }
    @IBAction func greenPicker(_ sender: Any) {
        bluePicker.isOn = false
        winePicker.isOn = false
    }
    @IBAction func winePicker(_ sender: Any) {
        bluePicker.isOn = false
        greenPicker.isOn = false
    }
    @IBAction func btnSave(_ sender: Any) {
        settingViewsHide()
        if bluePicker.isOn {
            self.back = UIColor(named: "blue")
            self.mainView.backgroundColor = self.back
        }
        if greenPicker.isOn {
            self.back = UIColor(named: "green")
            self.mainView.backgroundColor = self.back
        }
        if winePicker.isOn {
            self.back = UIColor(named: "wine")
            self.mainView.backgroundColor = self.back
        }
        if firstStage.isOn {
            self.stage = 0
        }
        if secondStage.isOn {
            self.stage = 1
        }
        if thirdStage.isOn {
            self.stage = 2
        }
        saveData(stage: stage, color: back!)
    }
    
    @IBAction func btnRules(_ sender: Any) {
        
    }
    
    @IBAction func btnCntnG(_ sender: UIButton) {
        update()
        enabledBtn()
    }
    @IBAction func btnMain(_ sender: Any) {
        hiddenOff()
    }
    @IBAction func winner(_ sender: Any) {
        enabledBtn()
        game.openAllCard(players: &game.Players, table: &game.table)
        game.setPictCard(players: game.Players, pict: playersImg, stage: stage)
        game.setPictCardTable(table: game.table, pict: tableImg, stage: stage)
        if (firstWinner.isTouchInside && result[0].1) || (secondWinner.isTouchInside && result[1].1) || (thirdWinner.isTouchInside && result[2].1) {
            textWinner.text = "Верно!"
            textWinner.backgroundColor = .green
        } else {
            textWinner.text = "Неверно!"
            textWinner.backgroundColor = .red
        }
    }
}

