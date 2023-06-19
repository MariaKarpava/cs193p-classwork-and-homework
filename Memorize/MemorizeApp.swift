//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Maryia Karpava on 20/02/2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var store = ThemeStore()
    
    var body: some Scene {
        WindowGroup {
            ThemeChooserView()
                .environmentObject(store)
            
        }
    }
}
