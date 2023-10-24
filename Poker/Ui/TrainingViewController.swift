//
//  TrainingViewController.swift
//  Poker
//
//  Created by Егор on 22.10.2023.
//

import UIKit

class TrainingViewController: UIViewController {

    var game = Game()
    let data = Settings.shared
    
    var result:[(String, Bool)] = []
    var playersImg: [[UIImageView]] = []
    var tableImg: [UIImageView] = []
    
    @IBOutlet weak var textWinner: UILabel!
    
    @IBOutlet weak var firstWinner: UIButton!
    @IBOutlet weak var secondWinner: UIButton!
    @IBOutlet weak var thirdWinner: UIButton!
    
    @IBOutlet weak var labelPl1: UILabel!
    @IBOutlet weak var imgPl1c1: UIImageView!
    @IBOutlet weak var imgPl1c2: UIImageView!
    
    @IBOutlet weak var labelPl2: UILabel!
    @IBOutlet weak var imgPl2c1: UIImageView!
    @IBOutlet weak var imgPl2c2: UIImageView!
    
    @IBOutlet weak var labelPl3: UILabel!
    @IBOutlet weak var imgPl3c1: UIImageView!
    @IBOutlet weak var imgPl3c2: UIImageView!
    
    @IBOutlet weak var imgTblc1: UIImageView!
    @IBOutlet weak var imgTblc2: UIImageView!
    @IBOutlet weak var imgTblc3: UIImageView!
    @IBOutlet weak var imgTblc4: UIImageView!
    @IBOutlet weak var imgTblc5: UIImageView!
    
    func update() {
        self.view.backgroundColor = data.getData().1
        game = Game()
        
        game.Players = game.PlayersInit(numberOfPlayers: 3)
        game.setPictCard(players: game.Players, pict: playersImg, stage: data.getData().0)
        
        game.table = game.contGame()
        game.setPictCardTable(table: game.table, pict: tableImg, stage: data.getData().0)
        
        result = game.winner(table: game.table, players: game.Players)
        result.shuffle()
        
        textWinner.text = "Кто выиграет?"
        textWinner.backgroundColor = .systemGray4
        
        firstWinner.setTitle(result[0].0, for: .normal)
        secondWinner.setTitle(result[1].0, for: .normal)
        thirdWinner.setTitle(result[2].0, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playersImg = [[imgPl1c1,imgPl1c2],[imgPl2c1,imgPl2c2],[imgPl3c1,imgPl3c2]]
        self.tableImg = [imgTblc1,imgTblc2,imgTblc3,imgTblc4,imgTblc5]
        
        update()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func winner(_ sender: Any) {
        game.openAllCard(players: &game.Players, table: &game.table)
        game.setPictCard(players: game.Players, pict: playersImg, stage: data.getData().0)
        game.setPictCardTable(table: game.table, pict: tableImg, stage: data.getData().0)
        if (firstWinner.isTouchInside && result[0].1) || (secondWinner.isTouchInside && result[1].1) || (thirdWinner.isTouchInside && result[2].1) {
            textWinner.text = "Верно!"
            textWinner.backgroundColor = .green
        } else {
            textWinner.text = "Неверно!"
            textWinner.backgroundColor = .red
        }
    }
    
    @IBAction func updateBtn(_ sender: UIButton) {
        update()
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
