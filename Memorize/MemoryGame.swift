//
//  MemoryGame.swift
//  Memorize
//
//  Created by Maryia Karpava on 02/03/2023.
//


import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    // It is an optional because at the beginning of the play we don't have this card so we can not initialise it
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private(set) var score = 0
    var startTime: Date?
    
    private var rememberedChoices: [Choice] = []
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsIfCards * 2 cards to cards array
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        guard isChoosable(card) else { return }
        guard let currentIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
        
        let isBeginningOfANewRound = rememberedChoices.isEmpty
        if isBeginningOfANewRound { makeAllCardsFaceDown() }
        
        rememberedChoices.append(Choice(what: currentIndex, when: .now))
        cards[currentIndex].isFaceUp = true
        
        guard rememberedChoices.count == 2 else { return }
        
        processRound(rememberedChoices[0], rememberedChoices[1])
        rememberedChoices = []
    }
    
    private mutating func processRound(_ choice1: Choice, _ choice2: Choice) {
        let isMatch = isMatch(choice1.index, choice2.index)
        if isMatch {
            [choice1, choice2].forEach { cards[$0.index].isMatched = true }
        }
        
        score += scoreForRound(choice1, choice2, isMatch: isMatch)
        
        // Note: mark as seen in the end because we don't want it to affect score calculation for current pair.
        [choice1, choice2].forEach { cards[$0.index].hasBeenSeen = true }
    }
    
    private mutating func makeAllCardsFaceDown() {
        cards.indices.forEach { cards[$0].isFaceUp = false }
    }
    
    private func isChoosable(_ card: Card) -> Bool {
        return !card.isFaceUp && !card.isMatched
    }
    
    private func timeBetween(_ choice1: Choice, _ choice2: Choice) -> TimeInterval {
        return choice2.time.timeIntervalSince(choice1.time)
    }
    
    private func isMatch(_ card1Index: Int, _ card2Index: Int) -> Bool {
        return cards[card1Index].content == cards[card2Index].content
    }
    
    private func scoreForRound(_ choice1: Choice, _ choice2: Choice, isMatch: Bool) -> Int {
        let secondsBetweenChoices = timeBetween(choice1, choice2)
        let multiplier = Int(max(10 - (secondsBetweenChoices), 1))
        let baseScore = baseScoreForRound(choice1, choice2, isMatch: isMatch)
        
        return multiplier * baseScore
    }
    
    private func baseScoreForRound(_ choice1: Choice, _ choice2: Choice, isMatch: Bool) -> Int {
        var baseScore: Int
        if isMatch {
            baseScore = 2
        } else {
            let seenCardsCount = [choice1, choice2]
                .map { cards[$0.index] }
                .map { $0.hasBeenSeen ? 1 : 0 }
                .reduce(0, +)
            baseScore = -1 * seenCardsCount
        }
        return baseScore
    }
    
    mutating func choose_old(_ card: Card) {
        var correctedPoints = 0
        
        // indexOfTheOneAndOnlyFaceUpCard = nil
        
        // if let as .firstIndex returns optional
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), // always true
           !cards[chosenIndex].isFaceUp, // = face down
           !cards[chosenIndex].isMatched // = not matched = present
        {
            // if indexOfTheOneAndOnlyFaceUpCard exists
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // = 2nd step
                let endTime = Date()
                print("endTime: \(endTime) sec")
                
                let timeInterval = endTime.timeIntervalSince(startTime!)
                print("time elapsed = \(timeInterval)")
                
                correctedPoints = Int(max(10 - (timeInterval), 1))
                print(correctedPoints)
                // if card2 == card1
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2 * correctedPoints
                } else {
                    if cards[chosenIndex].hasBeenSeen && cards[potentialMatchIndex].hasBeenSeen {
                        score -= 2 * correctedPoints
                    } else if cards[chosenIndex].hasBeenSeen || cards[potentialMatchIndex].hasBeenSeen {
                        score -= 1 * correctedPoints
                    }
                }
                // index of card1 = nil
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                // 1st step
                // indexOfTheOneAndOnlyFaceUpCard not exists: start of a new game or when more than one card is open
                for index in cards.indices {
                    if cards[index].isFaceUp {
                        cards[index].isFaceUp = false
                        cards[index].hasBeenSeen = true
                    }
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                startTime = Date()
                print("startTime: \(startTime!)")
            }
             cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    func index(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var hasBeenSeen = false
        var id: Int
    }
    
    private struct Choice {
        let index: Int
        let time: Date
        
        init(what index: Int, when time: Date) {
            self.index = index
            self.time = time
        }
    }
}
