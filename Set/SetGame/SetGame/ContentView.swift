//
//  ContentView.swift
//  SetGame
//
//  Created by Maryia Karpava on 01/04/2023.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        AspectVGrid(items: Cards.createCards(), aspectRatio: 2/3, minWidth: 70) { card in
            CardView()
        }
    }      
}




struct Card: Identifiable {
    var isSelected: Bool = false
    let id = UUID()
}


struct Cards {
    static func createCards() -> [Card] {
        var cards:[Card] = []
        
        for _ in 0..<81 {
            cards.append(Card())
        }
        return cards
    }
}




struct CardView: View {
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.red)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
