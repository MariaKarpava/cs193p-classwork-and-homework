//
//  ColourPicker.swift
//  Memorize
//
//  Created by Maryia Karpava on 14/06/2023.
//

import SwiftUI



struct ColourPicker: View {
    @State private var selectedColor = Color.red
    
    var body: some View {
        VStack {
            ColorPicker("Select a color", selection: $selectedColor)
                .frame(width: 200, height: 200)
            
            Rectangle()
                .fill(selectedColor)
                .frame(width: 50, height: 70)
                .cornerRadius(10)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ColourPicker()
    }
}

