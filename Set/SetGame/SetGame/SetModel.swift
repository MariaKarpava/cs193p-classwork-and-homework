//
//  File.swift
//  SetGame
//
//  Created by Maryia Karpava on 01/04/2023.
//

import Foundation


struct CardModel: Identifiable, Hashable {
    var isSelected = false
    var matchingState: MatchingStates = .unknown
    
    enum MatchingStates {
        case success
        case notSuccess
        case unknown
    }
    
    let shapes: String
    let numberOfShapes: Int
    let colours: String
    let shading: String
    
    let id = UUID()
}


struct CardDeck {
    var cards = Set(Self.createCards())
    
    static private func createCards() -> [CardModel] {
        var allCards:[CardModel] = []
        
        let shapes = ["diamond", "oval", "square"]
        let numberOfShapes = [1, 2, 3]
        let colours = ["red", "green", "purple"]
        let shading = ["solid", "semi-transparent", "outlined"]
    
        
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


