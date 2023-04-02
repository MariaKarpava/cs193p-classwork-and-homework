//
//  ContentView.swift
//  SetGame
//
//  Created by Maryia Karpava on 01/04/2023.
//


import SwiftUI

struct ContentView: View {
    let columns = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    var body: some View {
        ScrollView (.vertical) {
            LazyVGrid(columns: columns) {
                ForEach(Cards.createCards(), id: \.id) { card in
                    CardView().aspectRatio(2/3, contentMode: .fit)
                }
            }
            .foregroundColor(.red)
        }
    }      
}




struct Card {
    var isSelected: Bool = false
    let id = UUID()
}


struct Cards {
    static func createCards() -> [Card] {
        var cards:[Card] = []
        
        for _ in 0..<20 {
            cards.append(Card())
        }
        return cards
    }
}




struct CardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.red)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
