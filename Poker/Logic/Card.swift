//
//  Card.swift
//  Poker
//
//  Created by Егор on 27.06.2023.
//

import Foundation

struct Card: Hashable {
    var rank: Rank
    var suit: Suit
    public var closed: Bool = true
    
    init(_ rank: Rank, _ suit: Suit, _ closed: Bool) {
        self.rank = rank
        self.suit = suit
        self.closed = closed
    }
    
    func formatted(stage: Int) -> String {
        var formattedCard = ""
        formattedCard.append("\(stage)")
        switch rank {
        case .Ace:
            formattedCard.append("AceOf")
        case .Two:
            formattedCard.append("TwoOf")
        case .Three:
            formattedCard.append("ThreeOf")
        case .Four:
            formattedCard.append("FourOf")
        case .Five:
            formattedCard.append("FiveOf")
        case .Six:
            formattedCard.append("SixOf")
        case .Seven:
            formattedCard.append("SevenOf")
        case .Eight:
            formattedCard.append("EightOf")
        case .Nine:
            formattedCard.append("NineOf")
        case .Ten:
            formattedCard.append("TenOf")
        case .Jack:
            formattedCard.append("JackOf")
        case .Queen:
            formattedCard.append("QueenOf")
        case .King:
            formattedCard.append("KingOf")
        }
        
        switch suit {
        case .Hearts:
            formattedCard.append("Hearts")
        case .Diamonds:
            formattedCard.append("Diamonds")
        case .Spades:
            formattedCard.append("Spades")
        case .Clubs:
            formattedCard.append("Clubs")
        }
        return formattedCard
    }
}
