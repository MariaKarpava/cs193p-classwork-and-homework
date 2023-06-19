//
//  Theme.swift
//  Memorize
//
//  Created by Maryia Karpava on 08/03/2023.
//

import Foundation

struct Theme: Identifiable, Hashable, Codable {
    var name: String
    var colour: RGBAColor
    var emojis: Array<String>
    var numberOfPairsOfCardsToShow: Int
    var id = UUID()

    

    struct RGBAColor: Codable, Equatable, Hashable {
     let red: Double
     let green: Double
     let blue: Double
     let alpha: Double
    }
    
    
    init(name: String, colour: RGBAColor, emojis: Array<String>, numberOfPairsOfCardsToShow: Int) {
        self.name = name
        self.colour = colour
        self.emojis = emojis
        self.numberOfPairsOfCardsToShow = numberOfPairsOfCardsToShow > emojis.count ? emojis.count : numberOfPairsOfCardsToShow
    }
    
}
