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
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
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
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
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
