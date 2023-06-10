//
//  ThemeStore.swift
//  Memorize
//
//  Created by Maryia Karpava on 07/06/2023.
//

import Foundation
import SwiftUI


class ThemeStore: ObservableObject {
//    @Published var themes = [Theme]()
    
    
    @Published var themes: Array<Theme> = [
//        Theme(name: "Animals", colour: "green", emojis: ["🐶", "🐭", "🦊", "🐻", "🐼", "🐸", "🐵", "🐥", "🦄", "🐰", "🐷", "🐴", "🦉", "🐱", "🐹", "🐻‍❄️", "🐨", "🐤", "🦁", "🐒", "🦋", "🐺"]),
//        Theme(name: "Vehicles", colour: "red", emojis: ["✈️", "🚁", "🚘", "🚃", "🚇"]),
        
        Theme(
            name: "House",
            colour: "blue",
            emojis: ["🛁", "🛏️", "🔑", "🪑", "🧸", "🖼️", "🪞", "🚽", "🛋️"],
            numberOfPairsOfCardsToShow: 9,
            id: 3
        ),
        Theme(
            name: "Body",
            colour: "yellow",
            emojis: ["🦶🏻", "🦵", "🦷", "👅", "👄", "👂", "👃", "👁️", "🫀"],
            numberOfPairsOfCardsToShow: 9,
            id: 4
        ),
        Theme(
            name: "Clothes",
            colour: "brown",
            emojis: ["👕", "👖", "👗", "🩱", "👘", "👠", "🥾", "👒", "👙"],
            numberOfPairsOfCardsToShow: 9,
            id: 5
        ),
        Theme(
            name: "Fruits",
            colour: "orange",
            emojis: ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐"],
            numberOfPairsOfCardsToShow: 9,
            id: 6
        )
    ]
     
}


