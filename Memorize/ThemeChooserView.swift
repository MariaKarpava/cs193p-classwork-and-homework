//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Maryia Karpava on 08/06/2023.
//

import SwiftUI

struct ThemeChooserView: View {
    @EnvironmentObject var store: ThemeStore
    @State private var editMode: EditMode = .inactive
    @State private var editing = false
    @State private var selectedTheme: Theme?
    @State private var games = [UUID: (EmojiMemoryGame, Theme)]()

    
    private var addNewThemeButton: some View {
            Button {
                selectedTheme = store.newTheme
            } label : {
                Image(systemName: "plus")
            }
    }
    

    
    func makeTapGesture(selectedTheme: Theme) -> some Gesture {
        TapGesture().onEnded {
            self.selectedTheme = selectedTheme
        }
    }
    
    
    // Need this because if you click Edit, new EmojiMemoryGame() is created and all the progress of the game is lost.
    private func destinationForChosenTheme(_ theme: Theme) -> some View {
        let newGame = EmojiMemoryGame(theme: theme)
        // Need the originalTheme because newGame is shuffled every time when it is created.
        let originalTheme = theme
        if games[theme.id] == nil {
            games[theme.id] = (newGame, originalTheme)
            return ContentView(viewModel: newGame)
        }
        if originalTheme != games[theme.id]?.1 {
            games[theme.id] = (newGame, originalTheme)
        }
        return ContentView(viewModel: games[theme.id]!.0)
    }
    
    

    
    var body: some View {
        VStack { // TODO: do we need this stack?
            NavigationView {
                List {
                    ForEach(store.themes) { theme in
                        NavigationLink(destination: destinationForChosenTheme(theme)) {
                            VStack(alignment: .leading) {
                                let color = Color(rgbaColor: theme.colour)
                                Text(theme.name).foregroundColor(color)
                                Text(theme.emojis.joined())
                            }
                            .lineLimit(1)
                            .gesture(editMode == .active ? makeTapGesture(selectedTheme: theme) : nil)
                        }
                    }
                    //teach the ForEach how to delete items
                    // at the indices in indexSet from its array
                    .onDelete { indexSet in
                        
                    }
                    // teach the ForEach how to move items
                    // at the indices in indexSet to a newOffset in its array
                    .onMove { indexSet, newOffset in
                        
                    }
                }
                .navigationTitle("Memorize") // TODO: should it belong here (to the List) or to the NavigationView?
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    addNewThemeButton
                    EditButton()
                }
                .environment(\.editMode, $editMode)
                .sheet(item: $selectedTheme) { theme in
                    if theme == store.newTheme {
                        ThemeEditor(theme: $store.newTheme)
                    } else {
                        let indexOfSelectedTheme = store.themes.firstIndex(where: { $0.id == theme.id })
                        ThemeEditor(theme: $store.themes[indexOfSelectedTheme!])
                    }
                }
            }
        }
        
    }
}



//struct ThemeChooserView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeChooserView()
//    }
//}



