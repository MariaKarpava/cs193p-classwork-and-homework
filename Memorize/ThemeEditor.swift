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
        }
    }
                    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    
    
//    struct StepperView: View {
//        @State private var value = 0
//        let step = 5
//        let range = 1...50
//
//
//        var body: some View {
//            Stepper(value: $value,
//                    in: range,
//                    step: step) {
//                Text("Current: \(value) in \(range.description) " +
//                     "stepping by \(step)")
//            }
//                .padding(10)
//        }
//    }
   
    
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



struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(ThemeStore().themes[0]))
            .previewLayout(.fixed(width: 300, height: 300))

    }
}

