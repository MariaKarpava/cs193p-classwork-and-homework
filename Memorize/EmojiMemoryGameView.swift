//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Maryia Karpava on 20/02/2023.
//

import SwiftUI


struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 66))]) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                    
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}



struct CardView: View {
    let card: EmojiMemoryGame.Card

    // I gave a card another name so it would not conflict with this name - private let card.
    // If to write card = cars Swift would not know which card is which.
    // If you want to use nice code that uses parameter names that match exactly the name of the var that you are going ti assign it to, you gonna type self.card.
    // It even color codes it perfectly.
    
    // add private to  let card
//    init(_ givenCard: EmojiMemoryGame.Card) {
//        card = givenCard
//    }
    
//    init(_ card: EmojiMemoryGame.Card) {
//        self.card = card
//    }
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
