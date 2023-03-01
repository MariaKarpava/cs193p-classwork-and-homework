//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Maryia Karpava on 02/03/2023.
//

// Our View Model:
// Intermidiatory between a Model and a View

import SwiftUI

//func makeCardContent(index: Int) -> String {
//    return "😃"
//}




class EmojiMemoryGame {
    static let emojis = ["🐶", "🐭", "🦊", "🐻", "🐼", "🐸", "🐵", "🐥", "🦄", "🐰", "🐷", "🐴", "🦉", "🐱", "🐹", "🐻‍❄️", "🐨", "🐤", "🦁", "🐒", "🦋", "🐺"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4, createCardContent: { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        })
    }

    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
}


