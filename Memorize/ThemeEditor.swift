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
//            addEmojisSection
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
    
    init(theme: Binding<Theme>) {
        _theme = theme
        // theme.wrappedValue is used to access the underlying value of the theme binding.
        _selectedColor = State(initialValue: Color(rgbaColor: theme.wrappedValue.colour))
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
    
    
    
    @State private var emojisToAdd: [String] = []
    
//    var addEmojisSection: some View {
//        Section(header: Text("Add Emojis")) {
//            TextField("", text: $emojisToAdd)
//                .onChange(of: emojisToAdd) { emojis in
//                    addEmojis(emojis)
//                }
//        }
//    }
    
    func addEmojis(_ emojis: [String]) {
        for emoji in emojis {
            theme.emojis.append(emoji)
        }
        
    }
}



//struct ThemeEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeEditor(theme: .constant(ThemeStore().themes[0]))
//            .previewLayout(.fixed(width: 300, height: 300))
//
//    }
//}

