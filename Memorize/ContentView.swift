//
//  ContentView.swift
//  Memorize
//
//  Created by Maryia Karpava on 20/02/2023.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            Text(viewModel.themeName)
                .foregroundColor(.red)
                .font(.largeTitle)
                .padding()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 66))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
            .padding(.horizontal)
            .padding(.bottom)
            
            Spacer()
            
            Button {
                viewModel.newGame()
            } label: {
                Text("New Game")
                    .foregroundColor(.red)
            }
            .font(.title2)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 20)
                .stroke(Color.red, lineWidth: 4))
        }
    }
}



struct CardView: View {
    let card: MemoryGame<String>.Card
    
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
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}




