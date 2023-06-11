//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Maryia Karpava on 02/03/2023.
//
import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private var theme: Theme
//     let chosenTheme: Theme
    
    @EnvironmentObject var store: ThemeStore
    
    /*
    static var themes: Array<Theme> = [
//        Theme(name: "Animals", colour: "green", emojis: ["🐶", "🐭", "🦊", "🐻", "🐼", "🐸", "🐵", "🐥", "🦄", "🐰", "🐷", "🐴", "🦉", "🐱", "🐹", "🐻‍❄️", "🐨", "🐤", "🦁", "🐒", "🦋", "🐺"]),
//        Theme(name: "Vehicles", colour: "red", emojis: ["✈️", "🚁", "🚘", "🚃", "🚇"]),
//        Theme(name: "House", colour: "blue", emojis: ["🛁", "🛏️", "🔑", "🪑", "🧸", "🖼️", "🪞", "🚽", "🛋️"], numberOfPairsOfCardsToShow: 9),
//        Theme(name: "Body", colour: "yellow", emojis: ["🦶🏻", "🦵", "🦷", "👅", "👄", "👂", "👃", "👁️", "🫀"], numberOfPairsOfCardsToShow: 9),
        Theme(name: "Clothes", colour: "brown", emojis: ["👕", "👖", "👗", "🩱", "👘", "👠", "🥾", "👒", "👙"], numberOfPairsOfCardsToShow: 9, id: 5),
        Theme(name: "Fruits", colour: "orange", emojis: ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐"], numberOfPairsOfCardsToShow: 9, id: 6)
    ]
    */
    
    var themeName: String {
        theme.name
    }
    
    
    var themeColour: Color {
        theme.uiColour
    }
    
    
    var score: Int {
        model.score
    }
    
    @Published private var model: MemoryGame<String>

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    init(theme: Theme) {
        self.theme = theme
        self.theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: self.theme)
    }
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCardsToShow, createCardContent: { pairIndex in
            theme.emojis[pairIndex]
        })
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
//        objectWillChange.send()
    }
    
    func newGame() {
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
}



struct Previews_EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

