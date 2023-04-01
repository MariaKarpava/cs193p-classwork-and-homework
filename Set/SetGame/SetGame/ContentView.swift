//
//  ContentView.swift
//  SetGame
//
//  Created by Maryia Karpava on 01/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Oval()
        }
        .padding()
    }
}

struct Oval: View {
    var body: some View {
        Ellipse()
            .fill(.blue)
            .frame(width: 100, height: 50)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
