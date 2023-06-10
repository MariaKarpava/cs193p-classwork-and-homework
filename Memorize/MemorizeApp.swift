//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Maryia Karpava on 20/02/2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
//    @StateObject var game = EmojiMemoryGame()
    @StateObject var themeStore = ThemeStore()
    
    var body: some Scene {
        WindowGroup {
            ThemeChooserView()
                .environmentObject(themeStore)
//            ContentView(viewModel: game)
        }
    }
}
