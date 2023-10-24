//
//  Hand.swift
//  Poker
//
//  Created by Егор on 30.06.2023.
//

import Foundation

struct Hand {
    
    public var cards: [Card]
    
    init(_ cards: [Card]) {
        self.cards = cards
    }
    
    static func + (_ lhs: Hand, _ rhs: Hand) -> Hand {
        return Hand(lhs.cards + rhs.cards)
    }
    
    public var sortedBySuit: [Card] {
        return cards.sorted {
            $0.suit.rawValue < $1.suit.rawValue
        }
    }
    public var sortedByRank: [Card] {
        return cards.sorted {
            $0.rank < $1.rank
        }
    }
    
    public var handStrength: HandStrength {
        return getHandStrength()
    }
    
    public func highCard() -> [Rank] {
        var bestHand: [Rank] = []
        for k in 2...6 {
            bestHand.append(sortedByRank[k].rank)
        }
        return bestHand
    }
    
    public func checkPair() -> (Bool, Rank, [Rank]) {
        var kickers: [Rank] = []
        var check: Int = 0
        let count = cards.count-1
        for i in 0..<count {
            if sortedByRank[count-i].rank == sortedByRank[count-i-1].rank {
                var k = sortedByRank.count-1
                while k >= 0 {
                    if sortedByRank[k].rank != sortedByRank[count-i].rank {
                        kickers.insert(sortedByRank[k].rank, at: 0)
                        check += 1
                    }
                    if check == 3 {
                        return (true, sortedByRank[count-i].rank, kickers)
                    }
                    k -= 1
                }
            }
        }
        return (false, .Two, [])
    }
    
    public func checkTwoPair() -> (Bool, Rank, Rank, Rank) {
        for i in 0...3 {
            if sortedByRank[3-i].rank == sortedByRank[3-i+1].rank {
                for j in 0...i {
                    if sortedByRank[5-j].rank == sortedByRank[5-j+1].rank {
                        var k = sortedByRank.count-1
                        while k >= 0 {
                            if sortedByRank[k].rank != sortedByRank[3-i].rank && sortedByRank[k].rank != sortedByRank[5-j].rank {
                                return (true, sortedByRank[3-i].rank, sortedByRank[5-j].rank, sortedByRank[k].rank)
                            }
                            k -= 1
                        }
                        
                    }
                }
            }
        }
        return (false, .Two, .Two, .Two)
    }
    
    public func checkTrips() -> (Bool, Rank, [Rank]) {
        var kickers: [Rank] = []
        var check: Int = 0
        for i in 0...4 {
            if sortedByRank[4-i].rank == sortedByRank[4-i+2].rank {
                var k = sortedByRank.count-1
                while k >= 0 {
                    if sortedByRank[k].rank != sortedByRank[4-i].rank {
                        kickers.insert(sortedByRank[k].rank, at: 0)
                        check += 1
                    }
                    if check == 2 {
                        return (true, sortedByRank[4-i].rank, kickers)
                    }
                    k -= 1
                }
            }
        }
        return (false, .Two, [])
    }
    
    public func checkQuads() -> (Bool, Rank, Rank) {
        for i in 0...3 {
            if sortedByRank[3-i].rank == sortedByRank[3-i+3].rank {
                var k = sortedByRank.count-1
                while k >= 0 {
                    if sortedByRank[k].rank != sortedByRank[3-i].rank{
                        return (true, sortedByRank[3-i].rank, sortedByRank[k].rank)
                    }
                    k -= 1
                }
            }
        }
        return (false, .Two, .Two)
    }
    
    public func checkFullHouse() -> (Bool, Rank, Rank) {
        for i in 0...2 {
            if sortedByRank[2-i].rank == sortedByRank[2-i+1].rank {
                for j in 0...i {
                    if sortedByRank[4-j].rank == sortedByRank[4-j+2].rank {
                        return (true, sortedByRank[2-i].rank, sortedByRank[4-j].rank)
                    }
                }
            }
        }
        for i in 0...2 {
            if sortedByRank[2-i].rank == sortedByRank[2-i+2].rank {
                for j in 0...i {
                    if sortedByRank[5-j].rank == sortedByRank[5-j+1].rank {
                        return (true, sortedByRank[5-j].rank, sortedByRank[2-i].rank)
                    }
                }
            }
        }
        return (false, .Two, .Two)
    }
    
    public func checkStraight() -> (Bool, Rank, [Card]) {
        var set: [Card] = []
        for card in sortedByRank {
            var check = false
            for cd in set {
                if card.rank == cd.rank {
                    check = true
                    break
                }
            }
            if !check {
                set.append(card)
            } else {
                check = false
            }
        }
        switch set.count {
        case 7:
            for i in 0...2 {
                if set[6-i].rank.rawValue - set[6-i-4].rank.rawValue == 4 {
                    var rez: [Card] = []
                    for j in 6-i-4...6-i {
                        rez.append(set[j])
                    }
                    return (true, set[6-i].rank, rez)
                }
            }
            if set[6].rank == .Ace {
                if set[3].rank == .Five {
                    var rez: [Card] = []
                    for i in 0...3 {
                        rez.append(set[i])
                    }
                    rez.append(set[6])
                    return (true, .Five, rez)
                }
            }
            return (false, .Two, [])
        case 6:
            for i in 1...2 {
                if set[6-i].rank.rawValue - set[6-i-4].rank.rawValue == 4 {
                    var rez: [Card] = []
                    for j in 6-i-4...6-i {
                        rez.append(set[j])
                    }
                    return (true, set[6-i].rank, rez)
                }
            }
            if set[5].rank == .Ace {
                if set[3].rank == .Five {
                    var rez: [Card] = []
                    for i in 0...3 {
                        rez.append(set[i])
                    }
                    rez.append(set[5])
                    return (true, set[3].rank, rez)
                }
            }
            return (false, .Two, [])
        case 5:
            if (set[4].rank.rawValue - set[0].rank.rawValue == 4) {
                return (true, set[4].rank, set)
            } else if set[4].rank == .Ace {
                if set[3].rank == .Five {
                    var rez: [Card] = []
                    for i in 0...3 {
                        rez.append(set[i])
                    }
                    rez.append(set[4])
                    return (true, set[3].rank, rez)
                }
            }
            return (false, .Two, [])
        default:
            return (false, .Two, [])
        }
    }
    
    public func checkFlush() -> (Bool, [Card]) {
        for i in 0...2 {
            if sortedBySuit[i].suit == sortedBySuit[i+4].suit {
                var set: [Card] = []
                let suit = sortedBySuit[i].suit
                for j in i...6 {
                    if suit == sortedByRank[j].suit && set.count != 5 {
                        set.append(sortedByRank[j])
                    }
                }
                return (true, set)
            }
        }
        return (false, [])
    }
    
    public func checkStraightFlush() -> (Bool, Rank) {
        let flush = checkFlush()
        let straight = checkStraight()
        if flush.0 && straight.0 {
            let set: Set = Set(flush.1 + straight.2)
            if set.count == flush.1.count && set.count == straight.2.count {
                return (true, straight.1)
            }
        }
        return (false, .Two)
    }
    
    private func getHandStrength() -> HandStrength {
        if checkStraightFlush().0 {
            return .straightFlush
        }
        if checkFlush().0 {
            return .flush
        }
        if checkStraight().0 {
            return .straight
        }
        if checkPair().0 {
            if checkTrips().0 {
                if checkQuads().0 {
                    return .fourOfAKind
                }
                if checkFullHouse().0 {
                    return .fullHouse
                }
                return .threeOfAKind
            }
            if checkTwoPair().0 {
                return .twoPair
            }
            return .pair
        }
        return .highCard
    }
}
