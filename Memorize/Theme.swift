//
//  Theme.swift
//  Memorize
//
//  Created by Maryia Karpava on 08/03/2023.
//

import Foundation

struct Theme: Identifiable, Hashable {
    var name: String
    var colour: String
    var emojis: Array<String>
    var numberOfPairsOfCardsToShow: Int
    let id: Int
    
    
    init(name: String, colour: String, emojis: Array<String>, numberOfPairsOfCardsToShow: Int, id: Int) {
        self.name = name
        self.colour = colour
        self.emojis = emojis
        self.numberOfPairsOfCardsToShow = numberOfPairsOfCardsToShow > emojis.count ? emojis.count : numberOfPairsOfCardsToShow
        self.id = id
    }
    
//    init(name: String, colour: String, emojis: Array<String>) {
//        self.name = name
//        self.colour = colour
//        self.emojis = emojis
//        // self.numberOfPairsOfCardsToShow = emojis.count
//        self.numberOfPairsOfCardsToShow = Int.random(in: 3...emojis.count)
//    }
    
    
}
