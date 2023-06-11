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


struct RGBAColor: Codable, Equatable, Hashable {
 let red: Double
 let green: Double
 let blue: Double
 let alpha: Double
}


extension Color {
 init(rgbaColor rgba: RGBAColor) {
 self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
 }
}


extension RGBAColor {
 init(color: Color) {
 var red: CGFloat = 0
 var green: CGFloat = 0
 var blue: CGFloat = 0
 var alpha: CGFloat = 0
 if let cgColor = color.cgColor {
 UIColor(cgColor: cgColor).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
 }
 self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
 }
}
