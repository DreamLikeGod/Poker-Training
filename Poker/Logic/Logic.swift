import Foundation
import UIKit

class Game {
    var deck = Deck.init()
    var Players = [Player]()
    var table = Table(Card(.Two, .Spades, true), Card(.Three, .Spades, true), Card(.Four, .Spades, true), Card(.Five, .Spades, true), Card(.Six, .Spades, true))
    var evaluator = Evaluator()
    
    func PlayersInit(numberOfPlayers: Int) -> [Player] {
        var plMas = [Player]()
        for _ in 0..<numberOfPlayers {
            let pl = Player()
            plMas.append(pl)
        }
        deck.shuffle()
        for _ in 0...1 {
            for j in plMas.indices {
                if let card = deck.deal() {
                    plMas[j].addCardToHand(card)
                }
            }
        }
        for x in plMas.indices {
            plMas[x].reverseObserveCard()
        }
        return plMas
    }
    
    func contGame() -> Table {
        var cards: [Card] = []
        for _ in 0...4 {
            if let card = deck.deal() {
                cards.append(card)
            }
        }
        var table = Table(cards[0], cards[1], cards[2], cards[3], cards[4])
        table.setClose()
        return table
    }
    
    func setPictCard(players: [Player], pict: [[UIImageView]], stage: Int) {
        for x in pict.indices {
            for y in pict[x].indices {
                let (close, image) = players[x].getImage(at: y, stage: stage)
                pict[x][y].image = UIImage.init(named: close ? "\(stage)Closed" : image)
            }
        }
    }
    func setPictCardTable(table: Table, pict: [UIImageView], stage: Int) {
        for x in 0...4 {
            let (close, image) = table.getImage(at: x, stage: stage)
            pict[x].image = UIImage.init(named: close ? "\(stage)Closed" : image)
        }
    }
    
    func openAllCard(players: inout [Player], table: inout Table) {
        for p in players.indices {
            players[p].reverseObserveCard()
        }
        table.setClose()
    }
    
    func winner(table: Table, players: [Player]) -> [(String, Bool)] {
        var highCombin: HandStrength = .highCard
        var againg: (HandStrength, Int) = (.highCard, 0)
        var rez: [(HandStrength, Int)] = []
        for k in 0..<players.count {
            let hand = table.cards + players[k].hand
            let strenght = hand.handStrength
            againg = (strenght, k)
            rez.append(againg)
            if highCombin < strenght {
                highCombin = strenght
            }
        }
        var choseWinners: [Player] = []
        var i = rez.count-1
        while i >= 0 {
            let (comb, id) = rez[i]
            if comb != highCombin {
                rez.remove(at: i)
            } else {
                choseWinners.insert(players[id], at: 0)
            }
            i -= 1
        }
        var result: [(String,Bool)] = []
        if rez.count > 1 {
            let winners = evaluator.evaluateWinners(table: table, players: choseWinners, combin: highCombin)
            if winners.count>1 {
                switch winners.count {
                case 3...:
                    var text = ""
                    text.append("Ничья!\n")
                    for k in winners {
                        text.append(" #\(rez[k].1+1)")
                    }
                    result.append((text, true))
                    for i in 0...1 {
                        var text = ""
                        var j = 2
                        if i == 0 {
                            j = Int.random(in: 1...winners.count-1)
                        }
                        text.append("""
                                    Ничья!
                                    #\(i+1) \(j+1)
                                    """)
                        result.append((text, false))
                    }
                case 2:
                    for i in 0...1 {
                        for j in i+1...2 {
                            var text = ""
                            var win = false
                            text.append("""
                                        Ничья!
                                        #\(i+1) \(j+1)
                                        """)
                            if i == winners[0] && j == winners[1] {
                                win = true
                            }
                            result.append((text, win))
                        }
                    }
                default:
                    fatalError("Здесь нет победителей!")
                }
            } else {
                for i in players.indices {
                    var text = ""
                    var win = false
                    text.append("Игрок #\(i+1)")
                    if i == rez[winners[0]].1 {
                        win = true
                    }
                    result.append((text, win))
                }
            }
        } else {
            for i in players.indices {
                var text = ""
                var win = false
                text.append("Игрок #\(i+1)")
                if i == rez[0].1 {
                    win = true
                }
                result.append((text, win))
            }
        }
        return result
    }
}
