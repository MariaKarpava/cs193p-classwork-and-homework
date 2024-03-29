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
        // Aspect- Short for aspect ratio as it uses the aspect ratio to pick the size if the views in there.
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
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
                    /*
                    Zero starts to the right. So anytime you specify an angle, if you
                    want to be thinking compass rose, you need to subtract 90 degrees
                    from any angle  you are using.
                    Also origin when you are drawing starts from top left corner. 
                     */
                    // -90, 60
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 150-90))
                        .padding(5).opacity(0.5)
                    
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
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        
        return EmojiMemoryGameView(game: game)
    }
}
