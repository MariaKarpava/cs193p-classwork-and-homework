//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Maryia Karpava on 12/06/2023.
//

import SwiftUI


struct ThemeEditor: View {
    @Binding var theme: Theme
    @EnvironmentObject var store: ThemeStore
    
    
    @State private var addingNewThemeMode = false
    
    private var saveButton: some View {
            Button {
                if themeIsNew && theme.emojis.count >= 2 {
                    store.themes.append(theme)
                    store.saveData()
//                    print("1:")
//                    print(theme)
//                    print("2:")
//                    print(store.themes)
                    
                } else if themeIsNew && theme.emojis.count < 2 {
                    return
                } else {
                    store.saveData()
                }
                
            } label : {
                Text("Save")
            }
    }
    
//    var permanentTheme: Theme {
//        return theme == store.newTheme ? store.newTheme : theme
//    }
    
    var themeIsNew: Bool {
        for t in store.themes {
            if t == theme {
                return false
            }
        }
        return true
    }
    
    
    
    
    
    var body: some View {
        VStack{
            Form {
                nameSection
                addEmojisSection
                removeEmojisSection
                cardPairSection
                colorPicker
            }.onChange(of: theme) { _ in
                store.saveData()
            }
            
            saveButton
                .buttonStyle(.bordered)
        }
        
    }
                    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
   
    
    var cardPairSection: some View {
//        let range = 0...$theme.emojis.count
        let range = theme == store.newTheme ? 0...$theme.emojis.count : 2...$theme.emojis.count
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
        let arrOfEmojisToAdd = emojis.emojiArray
        
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
    
    
    
}



