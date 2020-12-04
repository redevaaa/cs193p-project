//
//  Card.swift
//  Concentration
//
//  Created by admin on 2020/12/3.
//

import Foundation

struct Card: Hashable {
    func hash(into hasher: inout Hasher) { hasher.combine(identifier) }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
