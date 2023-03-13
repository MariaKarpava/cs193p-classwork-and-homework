//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Maryia Karpava on 02/03/2023.
//
import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private var theme: Theme
    
    static var themes: Array<Theme> = [
        Theme(name: "Animals", colour: "green", emojis: ["🐶", "🐭", "🦊", "🐻", "🐼", "🐸", "🐵", "🐥", "🦄", "🐰", "🐷", "🐴", "🦉", "🐱", "🐹", "🐻‍❄️", "🐨", "🐤", "🦁", "🐒", "🦋", "🐺"], numberOfPairsOfCardsToShow: 13),
        Theme(name: "Vehicles", colour: "red", emojis: ["✈️", "🚁", "🚘", "🚃", "🚇", "🚛", "🛳️", "🚲", "🛴"], numberOfPairsOfCardsToShow: 9),
        Theme(name: "House", colour: "blue", emojis: ["🛁", "🛏️", "🔑", "🪑", "🧸", "🖼️", "🪞", "🚽", "🛋️"], numberOfPairsOfCardsToShow: 9),
        Theme(name: "Body", colour: "yellow", emojis: ["🦶🏻", "🦵", "🦷", "👅", "👄", "👂", "👃", "👁️", "🫀"], numberOfPairsOfCardsToShow: 9),
        Theme(name: "Clothes", colour: "brown", emojis: ["👕", "👖", "👗", "🩱", "👘", "👠", "🥾", "👒", "👙"], numberOfPairsOfCardsToShow: 9),
        Theme(name: "Fruits", colour: "orange", emojis: ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐"], numberOfPairsOfCardsToShow: 9)
    ]
    
    var themeName: String {
        theme.name
    }
    
    @Published private var model: MemoryGame<String>

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    init() {
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCardsToShow, createCardContent: { pairIndex in
            return theme.emojis[pairIndex]
        })
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
//        objectWillChange.send()
    }
    
    func newGame() {
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
}



struct Previews_EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
