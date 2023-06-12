//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Maryia Karpava on 12/06/2023.
//

import SwiftUI

struct ThemeEditor: View {
//    @State private var theme: Theme = ThemeStore().themes[0]
    @Binding var theme: Theme
    
    
    // I'm binding the text that's being edited to the name field in this @State (above).
    var body: some View {
        Form {
            TextField("Name", text: $theme.name)
                .frame(minWidth: 300, minHeight: 350)
        }
        
    }
}

//struct ThemeEditor_Previews: PreviewProvider {
//    static var previews: some View {
////        ThemeEditor()
////            .previewLayout(.fixed(width: 300, height: 300))
//
//    }
//}
