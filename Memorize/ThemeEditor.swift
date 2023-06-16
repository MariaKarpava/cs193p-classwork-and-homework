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
            removeEmojisSection
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
        let range = 2...$theme.emojis.count
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
    
    // TODO: Fix numberOfPairsOfCardsToShow
    func addEmojis(_ emojis: String) {
        // add emojis to theme.emojis
        // convert string to array of strings
//        print("emojis: \(emojis)")
        
        let arrOfEmojisToAdd = emojis.emojiArray //.map { String($0) }
//        let stringArray = characterArray.map { String($0) }
//        print("arrOfEmojisToAdd: \(arrOfEmojisToAdd)")
        
        
        
        var updatedThemeEmojis = emojisInTheme + arrOfEmojisToAdd
        updatedThemeEmojis = updatedThemeEmojis.removingDuplicateStrings
        
        // Does not help with all problems
        let numberOfEmojisInTheme = updatedThemeEmojis.count
        theme.numberOfPairsOfCardsToShow = numberOfEmojisInTheme
        theme.emojis = updatedThemeEmojis
        
//        print("theme.emojis: \(theme.emojis)")
        
    }
    
    // 🍏🍐🍊
    var removeEmojisSection: some View {
        Section(header: Text("Remove Emojis: tap to remove.")) {
            let emojis = theme.emojis
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.emojis.removeAll { $0 == emoji }
                                theme.numberOfPairsOfCardsToShow = min(theme.numberOfPairsOfCardsToShow, theme.emojis.count)
                            }
                        }
                }
            }
            .font(.system(size: 40))
        }
    }
    

    // also works
//    var removeEmojisSection: some View {
//        Section(header: Text("Remove Emojis: tap to remove.")) {
//            let emojis = theme.emojis
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
//                ForEach(emojis, id: \.self) { emoji in
//                    Text(emoji)
//                        .onTapGesture {
//                            withAnimation {
//                                theme.emojis.removeAll { character -> Bool in
//                                    return String(character) == emoji
//                                }
//                                theme.numberOfPairsOfCardsToShow = theme.emojis.count
//                            }
//                        }
//                }
//            }
//            .font(.system(size: 40))
//        }
//    }

    
    
    
    
    
/*
 doesn't work - The reason why the updated removeEmojisSection code you provided doesn't work is that you are modifying the theme object within the closure passed to removeAll. SwiftUI relies on property bindings and change tracking to update the UI properly, and modifying the theme object directly within the closure can cause unexpected behavior or crashes.
    
    The closure you pass to removeAll is not executed in the context of SwiftUI's view update cycle, so modifying the theme object directly can lead to inconsistencies.

    To ensure proper view updates, it's recommended to modify the theme object outside the closure, after the removeAll operation is complete. Here's an updated version of the removeEmojisSection that works correctly:
 */
//    var removeEmojisSection: some View {
//        Section(header: Text("Remove Emojis: tap to remove.")) {
//            let emojis = theme.emojis
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
//                ForEach(emojis, id: \.self) { emoji in
//                    Text(emoji)
//                        .onTapGesture {
//                            withAnimation {
//                                theme.emojis.removeAll { character -> Bool in
//                                    if String(character) == emoji {
//                                        theme.numberOfPairsOfCardsToShow -= 1
//                                        return true
//                                    }
//                                    return false
//                                }
//                            }
//                        }
//                }
//            }
//            .font(.system(size: 40))
//        }
//    }

}



