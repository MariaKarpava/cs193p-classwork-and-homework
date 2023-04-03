//
//  ContentView.swift
//  SetGame
//
//  Created by Maryia Karpava on 01/04/2023.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        AspectVGrid(items: CardsFactory.createCards(), aspectRatio: 2/3, minWidth: 70) { card in
            CardView(card: card).padding(4)
                
        }
    }      
}



// TODO: make sure *Model types know nothing about View-layer (SwiftUI). Hint: you draw views based on models.
struct CardModel: Identifiable {
    var isSelected: Bool = false
    
    let shapes: String
    let numberOfShapes: Int
    let colours: String
    let shading: String
    
    let id = UUID()
}


struct CardsFactory {
    static func createCards() -> [CardModel] {
        var allCards:[CardModel] = []
        
        let shapes = ["diamond", "oval", "square"]
        let numberOfShapes = [1, 2, 3]
        let colours = ["red", "green", "purple"]
        let shading = ["solid", "stripped", "outlined"]
    
        
        for shape in shapes {
            for number in numberOfShapes {
                for colour in colours {
                    for shade in shading {
                        let card = CardModel(shapes: shape, numberOfShapes: number, colours: colour, shading: shade)
                        allCards.append(card)
                    }
                }
            }
        }
        return allCards
    }
}


struct CardView: View {
    var card: CardModel
    
    var body: some View {
        GeometryReader { geometry in
            let shape = RoundedRectangle(cornerRadius: 10)
            shape.stroke(.red, lineWidth: 3)
            
            
                            
//            shape.overlay(alignment: .center) { card.shape
//                .frame(width: geometry.size.width*0.5, height: geometry.size.width*0.3)
//            }.foregroundColor(.white)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
