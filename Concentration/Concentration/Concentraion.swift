//
//  Concentraion.swift
//  Concentration
//
//  Created by admin on 2020/12/2.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    private(set) var score = 0
    private(set) var flipCount = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index),"Concentraion.chooseCard(at: \(index)): chosen index not in the cards")
        flipCount += 1
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[matchIndex].hasBeenFlippedAtLeastOne { score -= 1 }
                    if cards[index].hasBeenFlippedAtLeastOne { score -= 1 }
                    cards[matchIndex].hasBeenFlippedAtLeastOne = true
                    cards[index].hasBeenFlippedAtLeastOne = true
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards facing up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
        
    init(numberOfParisOfCards: Int) {
        assert(numberOfParisOfCards > 0, "Concentraion.init(\(numberOfParisOfCards): you must have at least one pair of cars ")
        for _ in 1...numberOfParisOfCards{
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
