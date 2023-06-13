//
//  ThemeStore.swift
//  Memorize
//
//  Created by Maryia Karpava on 07/06/2023.
//

import Foundation
import SwiftUI


class ThemeStore: ObservableObject {
    @Published var themes: Array<Theme> = [
        Theme(
            name: "House",
            colour: Theme.RGBAColor(color: UIColor.green),
            emojis: ["🛁", "🛏️", "🔑", "🪑", "🧸", "🖼️", "🪞", "🚽", "🛋️"],
            numberOfPairsOfCardsToShow: 9,
            id: 3
            
        ),
        Theme(
            name: "Body",
            colour: Theme.RGBAColor(color: UIColor.yellow),
            emojis: ["🦶🏻", "🦵", "🦷", "👅", "👄", "👂", "👃", "👁️", "🫀"],
            numberOfPairsOfCardsToShow: 9,
            id: 4
            
        ),
        Theme(
            name: "Clothes",
            colour: Theme.RGBAColor(color: UIColor.blue),
            emojis: ["👕", "👖", "👗", "🩱", "👘", "👠", "🥾", "👒", "👙"],
            numberOfPairsOfCardsToShow: 9,
            id: 5
            
        ),
        Theme(
            name: "Fruits",
            colour: Theme.RGBAColor(color: UIColor.orange),
            emojis: ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐"],
            numberOfPairsOfCardsToShow: 9,
            id: 6
            
        )
    ]
    
}





