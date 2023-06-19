//
//  ThemeStore.swift
//  Memorize
//
//  Created by Maryia Karpava on 07/06/2023.
//

import Foundation
import SwiftUI


class ThemeStore: ObservableObject {
    
    // @Published: any changes to this property will automatically trigger an update to the subscribed views.
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
    
    
    init() {
        readData() // Load data when initializing the class
    }

    // MARK: - Persistence
    // 1. Implement encoding and decoding: Use the Codable protocol.
    // 2. Save data: create a file and write the encoded data to it.
    // 3. Load data: read the file and decode the data.
    
    
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("themes.json")

    func saveData() {
        let myData = self.themes
        do {
            let jsonData = try JSONEncoder().encode(myData)
            try jsonData.write(to: fileURL)
            print("Data saved successfully.")
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    
    func readData() {
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let myData = try JSONDecoder().decode([Theme].self, from: jsonData)
            themes = myData
            print("Data loaded successfully.")
        } catch {
            print("Error loading data: \(error)")
        }
    }


    
}





