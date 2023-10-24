//
//  Hand.swift
//  Poker
//
//  Created by Егор on 30.06.2023.
//

import Foundation

struct Table {
    private var card1: Card
    private var card2: Card
    private var card3: Card
    private var card4: Card
    private var card5: Card
    public let cards: Hand
    
    init(_ cardOne: Card, _ cardTwo: Card, _ cardThree: Card,
         _ cardFour: Card, _ cardFive: Card) {
        let cardsArr = [cardOne, cardTwo, cardThree, cardFour, cardFive]
        for i in 0...3 {
            for j in i+1..<cardsArr.count - 1 {
                if cardsArr[i].rank == cardsArr[j].rank && cardsArr[i].suit == cardsArr[j].suit {
                    fatalError("Cannot use two identical cards to form a legal hand.")
                }
            }
        }
        card1 = cardOne
        card2 = cardTwo
        card3 = cardThree
        card4 = cardFour
        card5 = cardFive
        cards = Hand(cardsArr)
    }
    
    public func getImage(at index: Int, stage: Int) -> (Bool, String) {
        switch index {
        case 0:
            return (card1.closed, card1.formatted(stage: stage))
        case 1:
            return (card2.closed, card2.formatted(stage: stage))
        case 2:
            return (card3.closed, card3.formatted(stage: stage))
        case 3:
            return (card4.closed, card4.formatted(stage: stage))
        case 4:
            return (card5.closed, card5.formatted(stage: stage))
        default:
            return (true, "Closed")
        }
    }
    
    public mutating func setClose() {
        card1.closed = !card1.closed
        card2.closed = !card2.closed
        card3.closed = !card3.closed
        card4.closed = !card4.closed
        card5.closed = !card5.closed
    }
}
