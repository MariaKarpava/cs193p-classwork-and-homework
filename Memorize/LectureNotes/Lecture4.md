// 1
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    @ Published - in ViewModel - anytime this changes, it will automatically do ObjectWillChange.send(), that otherwise would be in func choose in VM.


//2 
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @ObservedObject - property wrapper in the View. All property wrappers require vars. View will redraw when sth changes in VM. We observe VM because it is ObsevableObject.
    

// 3
    MemoryGame is of generic type
    Equatable means can call ==

    struct MemoryGame<CardContent> where CardContent: Equatable {
        private(set) var cards: Array<Card> -- getter internal (visible from anywhere inside a project Memorize, setter private.
    
        private var indexOfTheOneAndOnlyFaceUpCard: Int? -- Both getter and setter are private
