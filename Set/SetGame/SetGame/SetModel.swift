//
//  File.swift
//  SetGame
//
//  Created by Maryia Karpava on 01/04/2023.
//

import Foundation

struct SetGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
}

struct Card {
    var isSelected: Bool
    var isMatched: Bool
    
    // let content: CardContent
    let id: Int
}

struct Deck {
    var cards: [Card]
    var numberOfCardsAtStart: Int = 12
    var numberOfCardsToAdd: Int = 3
    var numberOfCardsInDeck: Int = 81
    
    mutating func addCard(card: Card) {
        cards.append(card)
    }
}
