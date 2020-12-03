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
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index),"Concentraion.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards facing up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfParisOfCards: Int){
        assert(numberOfParisOfCards > 0, "Concentraion.init(\(numberOfParisOfCards): you must have at least one pair of cars ")
        for _ in 1...numberOfParisOfCards{
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
    }
}
