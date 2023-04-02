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
            CardView().padding(4)
                
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
            let shape = RoundedRectangle(cornerRadius: 10)
            shape.fill().foregroundColor(.white)
            shape.stroke(.red, lineWidth: 3)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
