//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Maryia Karpava on 12/06/2023.
//

import SwiftUI


struct ThemeEditor: View {
    @Binding var theme: Theme
    
    // I'm binding the text that's being edited to the name field in this @State (above).
    var body: some View {
        Form {
            nameSection
            addEmojisSection
            cardPairSection
            colorPicker
        }
    }
                    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    
    var cardPairSection: some View {
        let range = 2...$theme.emojis.count-1
        let step = 1
        
        return Section(header: Text("Card Count")) {
            Stepper(value: $theme.numberOfPairsOfCardsToShow,
                    in: range,
                    step: step) {
                Text("\(theme.numberOfPairsOfCardsToShow) Pairs")
            }
        }
    }
    
    
    // need this init to set the correct theme color in edit mode when launching the app.
    init(theme: Binding<Theme>) {
        _theme = theme
        // theme.wrappedValue is used to access the underlying value of the theme binding, which is of type Theme.RGBAColor
        // Then, the extracted value is passed to the Color init to create the initial value for the selectedColor state property.
        _selectedColor = State(initialValue: Color(rgbaColor: theme.wrappedValue.colour))
        _emojisInTheme = State(initialValue: theme.wrappedValue.emojis)
    }
    
    @State private var selectedColor: Color
        
    var colorPicker: some View {
        return Section(header: Text("Theme Color")) {
            ColorPicker(selection: $selectedColor, supportsOpacity: false) {
                Text("Select a color")
            }
            Rectangle()
                .fill(selectedColor)
                .frame(width: 30, height: 40)
                .cornerRadius(5)
            }
            .onChange(of: selectedColor) { newColor in
                theme.colour = Theme.RGBAColor(color: newColor)
            }
    }
    
    
    @State private var emojisInTheme: [String]
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("Emoji", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }
    
    // TODO: Problems
    //  1. parses 2 added emojis as 1
    //  2. when add not emoji with emojis (like  🍏🍐Masha) -> filters Masha and returns 🍏🍐 but on one card
    //  3. when add Masha - adds empty card
    //  4. when add "🍏", "🍐" - adds empty card
    //  5. when add emojis - pair count should be allowed to increase
    //  6. When I try to add sth and press + on the number of cards to show - it is decremented by 1.
    
    
    func addEmojis(_ emojis: String) {
        // add emojis to theme.emojis
        // convert string to array of strings
        print("emojis: \(emojis)")
        
        let arrOfEmojisToAdd = emojis.emojiArray //.map { String($0) }
//        let stringArray = characterArray.map { String($0) }
        print("arrOfEmojisToAdd: \(arrOfEmojisToAdd)")
        
        
        var updatedThemeEmojis = emojisInTheme + arrOfEmojisToAdd
        updatedThemeEmojis = updatedThemeEmojis.removingDuplicateStrings
        
        theme.emojis = updatedThemeEmojis
        
        print("theme.emojis: \(theme.emojis)")
        
    }
    
    
}



