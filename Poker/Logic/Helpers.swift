//
//  Helpers.swift
//  Poker
//
//  Created by Егор on 27.06.2023.
//

import Foundation

enum Suit: Int, CaseIterable, Equatable {
    case Hearts = 1
    case Diamonds = 2
    case Clubs = 3
    case Spades = 4
    
    static func == (_ lhs: Suit, _ rhs: Suit) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
enum Rank: Int, CaseIterable, Equatable, Comparable {
    case Ace = 14
    case King = 13
    case Queen = 12
    case Jack = 11
    case Ten = 10
    case Nine = 9
    case Eight = 8
    case Seven = 7
    case Six = 6
    case Five = 5
    case Four = 4
    case Three = 3
    case Two = 2
    
    static func < (_ lhs: Rank, _ rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func > (_ lhs: Rank, _ rhs: Rank) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
    
    static func == (_ lhs: Rank, _ rhs: Rank) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

enum HandStrength: Int, Comparable, Equatable {
    case highCard = 0
    case pair = 1
    case twoPair = 2
    case threeOfAKind = 3
    case straight = 4
    case flush = 5
    case fullHouse = 6
    case fourOfAKind = 7
    case straightFlush = 8
    
    static func < (_ lhs: HandStrength, _ rhs: HandStrength) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func > (_ lhs: HandStrength, _ rhs: HandStrength) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
    
    static func == (_ lhs: HandStrength, _ rhs: HandStrength) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
