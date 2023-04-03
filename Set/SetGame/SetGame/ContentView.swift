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
            CardView(card: card).padding(4)
                
        }
    }      
}


struct Card: Identifiable {
    var isSelected: Bool = false
    var shape: AnyView
    let id = UUID()
    
}


struct Cards {
    static func createCards() -> [Card] {
        var cards:[Card] = []
        
        for i in 0..<81 {
            var shape: AnyView = AnyView(Oval())
            
            if i % 3 == 0 {
                shape = AnyView(Diamond().foregroundColor(.red))
            } else if i % 2 == 0 {
                shape = AnyView(Square())
            }
            cards.append(Card(shape: shape))
        }
        return cards
    }
}


struct CardView: View {
    var card: Card
    
    var body: some View {
        GeometryReader { geometry in
            let shape = RoundedRectangle(cornerRadius: 10)
            
            shape.stroke(.red, lineWidth: 3)
            shape.overlay(alignment: .center) { card.shape
                .frame(width: geometry.size.width*0.5, height: geometry.size.width*0.3)
            }.foregroundColor(.white)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
