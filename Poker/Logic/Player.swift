//
//  Player.swift
//  Poker
//
//  Created by Егор on 27.06.2023.
//

import Foundation

struct Player {
    private var cards: [Card]
    public var hand: Hand {
        return Hand(cards)
    }
    
    init(_ cards: [Card] = [], _ hand: Hand? = nil) {
        self.cards = cards
    }
    
    public mutating func addCardToHand(_ card: Card) {
        if cards.count < 2 {
            cards.append(card)
        }
    }
    
    public mutating func reverseObserveCard() {
        for i in 0..<cards.count {
            cards[i].closed = !cards[i].closed
        }
    }
    
    public func getImage(at index: Int, stage: Int) -> (Bool, String) {
        return (cards[index].closed, cards[index].formatted(stage: stage))
    }
}
