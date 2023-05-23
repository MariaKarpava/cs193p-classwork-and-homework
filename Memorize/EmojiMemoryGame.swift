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




class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    // emojis should be unique. Otherwise, when user will try to match cards with the same emojis, he will not be able to match cards.
    private static let emojis = ["🐶", "🐭", "🦊", "🐻", "🐼", "🐸", "🐵", "🐥", "🦄", "🐰", "🐷", "🐴", "🦉", "🐱", "🐹", "🐻‍❄️", "🐨", "🐤", "🦁", "🐒", "🦋", "🐺","🐶", "🐭", "🦊", "🐻", "🐼", "🐸", "🐵", "🐥", "🦄", "🐰", "🐷", "🐴", "🦉", "🐱", "🐹", "🐻‍❄️", "🐨", "🐤", "🦁", "🐒", "🦋", "🐺","🐶", "🐭", "🦊", "🐻", "🐼", "🐸", "🐵", "🐥", "🦄", "🐰", "🐷", "🐴", "🦉", "🐱", "🐹", "🐻‍❄️", "🐨", "🐤", "🦁", "🐒", "🦋", "🐺"]
    
    // helps to create a model.
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 66, createCardContent: { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        })
    }
    
    /*
    To connect View and ViewModel
    In practical terms, that means whenever an object with a property marked @Published is changed, all views using that object will be reloaded to reflect those changes.
     */
    @Published private var model = createMemoryGame()

    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
}


