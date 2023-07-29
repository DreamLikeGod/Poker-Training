//
//  Evaluator.swift
//  Poker
//
//  Created by Егор on 08.07.2023.
//

import Foundation

struct Evaluator {
    
    func evaluateWinners(table: Table, players: [Player], combin: HandStrength) -> [Int] {
        switch combin {
        case .highCard:
            return evalHighCard(table: table, players: players)
        case .pair:
            return evalPair(table: table, players: players)
        case .twoPair:
            return evalTwoPair(table: table, players: players)
        case .threeOfAKind:
            return evalTrips(table: table, players: players)
        case .fullHouse:
            return evalFullhouse(table: table, players: players)
        case .fourOfAKind:
            return evalQuad(table: table, players: players)
        case .straight:
            return evalStraight(table: table, players: players)
        case .flush:
            return evalFlush(table: table, players: players)
        case .straightFlush:
            return evalStraightFlush(table: table, players: players)
        }
    }
    
    private func evalHighCard (table: Table, players: [Player]) -> [Int] {
        var highs: [Rank] = [.Two, .Two, .Two, .Two, .Two]
        var rez: [Int] = []
        for i in 0..<players.count {
            let newHand = Hand(table.cards.cards + players[i].hand.cards).highCard()
            var k = newHand.count-1
            while k >= 0 {
                if newHand[k] > highs[k] {
                    highs = newHand
                } else if newHand[k] < highs[k] {
                    break
                }
                k -= 1
            }
        }
        for i in 0..<players.count {
            let newHand = Hand(table.cards.cards + players[i].hand.cards).highCard()
            var k = newHand.count-1
            var check: Bool = true
            while k >= 0 {
                if newHand[k] != highs[k] {
                    check = false
                    break
                }
                k -= 1
            }
            if check {
                rez.append(i)
            } else {
                check = true
            }
        }
        return rez
    }
    
    private func evalPair (table: Table, players: [Player]) -> [Int] {
        var kickers: [[Rank]] = []
        var highKickers: [Rank] = [.Two, .Two, .Two]
        var pairs: [Rank] = []
        var maxPair: Rank = .Two
        var rez: [Int] = []
        for i in players {
            let newHand = Hand(table.cards.cards + i.hand.cards).checkPair()
            pairs.append(newHand.1)
            kickers.append(newHand.2)
            if maxPair < newHand.1 {
                maxPair = newHand.1
            }
        }
        for i in 0..<players.count {
            if maxPair == pairs[i] {
                var k = 2
                while k >= 0 {
                    if highKickers[k] < kickers[i][k] {
                        highKickers = kickers[i]
                    }
                    k -= 1
                }
            }
        }
        for i in 0..<players.count {
            if maxPair == pairs[i] && highKickers == kickers[i] {
                rez.append(i)
            }
        }
        return rez
    }
    
    private func evalTwoPair (table: Table, players: [Player]) -> [Int] {
        var firstPair: [Rank] = []
        var secondPair: [Rank] = []
        var kickers: [Rank] = []
        var maxPair: Rank = .Two
        var minPair: Rank = .Two
        var maxKicker: Rank = .Two
        var rez: [Int] = []
        for i in players {
            let newHand = Hand(table.cards.cards + i.hand.cards).checkTwoPair()
            kickers.append(newHand.3)
            firstPair.append(newHand.2)
            secondPair.append(newHand.1)
            if maxPair < newHand.2 {
                maxPair = newHand.2
            }
        }
        for i in 0..<secondPair.count {
            if minPair < secondPair[i] && maxPair == firstPair[i]  {
                minPair = secondPair[i]
            }
        }
        for i in 0..<players.count {
            if maxPair == firstPair[i] && minPair == secondPair[i] {
                if maxKicker < kickers[i] {
                    maxKicker = kickers[i]
                }
            }
        }
        for i in 0..<players.count {
            if maxPair == firstPair[i] && minPair == secondPair[i] && maxKicker == kickers[i] {
                rez.append(i)
            }
        }
        return rez
    }
    
    private func evalTrips (table: Table, players: [Player]) -> [Int] {
        var kickers: [[Rank]] = []
        var highKickers: [Rank] = [.Two, .Two]
        var trips: [Rank] = []
        var maxTrips: Rank = .Two
        var rez: [Int] = []
        for i in players {
            let newHand = Hand(table.cards.cards + i.hand.cards).checkTrips()
            trips.append(newHand.1)
            kickers.append(newHand.2)
            if maxTrips < newHand.1 {
                maxTrips = newHand.1
            }
        }
        for i in 0..<players.count {
            if maxTrips == trips[i] {
                var k = 1
                while k >= 0 {
                    if highKickers[k] < kickers[i][k] {
                        highKickers = kickers[i]
                    }
                    k -= 1
                }
            }
        }
        for i in 0..<players.count {
            if maxTrips == trips[i] && highKickers == kickers[i] {
                rez.append(i)
            }
        }
        return rez
    }
    
    private func evalFullhouse (table: Table, players: [Player]) -> [Int] {
        var trips: [Rank] = []
        var pairs: [Rank] = []
        var maxTrips: Rank = .Two
        var maxPair: Rank = .Two
        var rez: [Int] = []
        for i in players {
            let newHand = Hand(table.cards.cards + i.hand.cards).checkFullHouse()
            trips.append(newHand.2)
            pairs.append(newHand.1)
            if maxTrips < newHand.2 {
                maxTrips = newHand.2
            }
        }
        for i in 0..<pairs.count {
            if maxPair < pairs[i] && maxTrips == trips[i]  {
                maxPair = pairs[i]
            }
        }
        for i in 0..<players.count {
            if maxTrips == trips[i] && maxPair == pairs[i] {
                rez.append(i)
            }
        }
        return rez
    }
    
    private func evalQuad (table: Table, players: [Player]) -> [Int] {
        var quads: [Rank] = []
        var kickers: [Rank] = []
        var maxQuad: Rank = .Two
        var maxKicker: Rank = .Two
        var rez: [Int] = []
        for i in 0..<players.count {
            let newHand = Hand(table.cards.cards + players[i].hand.cards).checkQuads()
            kickers.append(newHand.2)
            quads.append(newHand.1)
            if maxQuad < newHand.1 {
                maxQuad = newHand.1
            }
        }
        for i in 0..<players.count {
            if maxQuad == quads[i] {
                if maxKicker < kickers[i] {
                    maxKicker = kickers[i]
                }
            }
        }
        for i in 0..<players.count {
            if maxQuad == quads[i] && maxKicker == kickers[i] {
                rez.append(i)
            }
        }
        return rez
    }
    
    private func evalStraight (table: Table, players: [Player]) -> [Int] {
        var straight: [Rank] = []
        var maxStraight: Rank = .Two
        var rez: [Int] = []
        for i in players {
            let newHand = Hand(table.cards.cards + i.hand.cards).checkStraight().1
            straight.append(newHand)
            if maxStraight < newHand {
                maxStraight = newHand
            }
        }
        for i in 0..<players.count {
            if maxStraight == straight[i] {
                rez.append(i)
            }
        }
        return rez
    }
    
    private func evalFlush (table: Table, players: [Player]) -> [Int] {
        var flushes: [[Rank]] = []
        var maxFlush: [Rank] = []
        var highFlush: [Rank] = [.Two, .Two, .Two, .Two, .Two]
        var highCard: Rank = .Two
        var rez: [Int] = []
        for i in 0..<players.count {
            let newHand = Hand(table.cards.cards + players[i].hand.cards).checkFlush()
            var ranks: [Rank] = []
            for j in 0..<newHand.1.count {
                ranks.append(newHand.1[j].rank)
            }
            flushes.append(ranks)
            maxFlush.append(ranks[4])
            if highCard < ranks[4] {
                highCard = ranks[4]
            }
        }
        for i in 0..<players.count {
            if highCard == maxFlush[i] {
                var k = highFlush.count-1
                while k >= 0 {
                    if highFlush[k] < flushes[i][k] {
                        highFlush = flushes[i]
                    }
                    k -= 1
                }
            }
        }
        for i in 0..<players.count {
            if highCard == maxFlush[i] && highFlush == flushes[i] {
                rez.append(i)
            }
        }
        return rez
    }
    
    private func evalStraightFlush (table: Table, players: [Player]) -> [Int] {
        var straightFlush: [Rank] = []
        var maxStraightFlush: Rank = .Two
        var rez: [Int] = []
        for i in players {
            let newHand = Hand(table.cards.cards + i.hand.cards).checkStraight().1
            straightFlush.append(newHand)
            if maxStraightFlush < newHand {
                maxStraightFlush = newHand
            }
        }
        for i in 0..<players.count {
            if maxStraightFlush == straightFlush[i] {
                rez.append(i)
            }
        }
        return rez
    }
}
