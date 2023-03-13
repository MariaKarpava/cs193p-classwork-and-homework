//
//  Theme.swift
//  Memorize
//
//  Created by Maryia Karpava on 08/03/2023.
//

import Foundation

struct Theme {
    var name: String
    var colour: String
    var emojis: Array<String>
    var numberOfPairsOfCardsToShow: Int
    
    init(name: String, colour: String, emojis: Array<String>, numberOfPairsOfCardsToShow: Int) {
        self.name = name
        self.colour = colour
        self.emojis = emojis
        self.numberOfPairsOfCardsToShow = numberOfPairsOfCardsToShow > emojis.count ? emojis.count : numberOfPairsOfCardsToShow
    }
    
    init(name: String, colour: String, emojis: Array<String>) {
        self.name = name
        self.colour = colour
        self.emojis = emojis
        // self.numberOfPairsOfCardsToShow = emojis.count
        self.numberOfPairsOfCardsToShow = Int.random(in: 3...emojis.count)
    }
    
    
}
