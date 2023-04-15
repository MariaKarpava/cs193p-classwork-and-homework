//
//  SetViewModel.swift
//  SetGame
//
//  Created by Maryia Karpava on 10/04/2023.
//

import Foundation


// TODO: restrict access as much as possible to members
class SetViewModel: ObservableObject {
    
    @Published var cardsToShow: [CardModel] = []
    var cardDeck = CardDeck()
    

    private func dealThreeCards() -> [CardModel] {
        var threeCards:[CardModel] = []
        
        for _ in 0..<3 {
            if let randomCard = cardDeck.cards.randomElement() {
                threeCards.append(randomCard)
                cardDeck.cards.remove(randomCard)
            }
        }
        return threeCards
    }
        
    func onDealCardsTapped() {
        let newThreeCards = dealThreeCards()
        if cardsToShow.count + newThreeCards.count > 81 {
            return
        }
        
        // if already selected 3 cards create set - replace these 3 cards with new ones
        // else - add 3 new cards to the end
        let selectedCards = cardsToShow.filter { $0.isSelected }
        if isSet(selectedCards: selectedCards) {
            var indexesOfSelectedCards = [Int]()

            for (index, card) in cardsToShow.enumerated() {
                if card.isSelected {
                    indexesOfSelectedCards.append(index)
                }
            }
            
            for i in 0..<cardsToShow.count {
                for j in 0..<selectedCards.count {
                    if cardsToShow[i] == selectedCards[j] {
                        cardsToShow[i] = newThreeCards[j]
                    }
                }
            }
        } else {
            cardsToShow.append(contentsOf: newThreeCards)
        }
        /*
        Simpler version of the same code:
         let selectedCards = cardsToShow.filter(\.isSelected)

         if isSet(selectedCards: selectedCards) {
             for (index, card) in cardsToShow.enumerated() where card.isSelected {
                 cardsToShow[index] = newThreeCards[selectedCards.firstIndex(of: card)!]
             }
         } else {
             cardsToShow += newThreeCards
         }
         */
    }
    
    func onNewGameTapped() {
        cardDeck = CardDeck()
        cardsToShow = random(12, from: cardDeck.cards)
        cardsToShow.forEach { cardDeck.cards.remove($0) }
    }
    
    
  
    func onCardSelected(cardId: UUID) {
        guard let selectedCardIndex = cardsToShow.firstIndex(where: { $0.id == cardId }) else {
            return
        }
        
        // Support “deselection” by touching already-selected cards (but only if there are 1 or 2
        // cards (not 3) currently selected).
        let selectedCard = cardsToShow[selectedCardIndex]
        if selectedCard.isSelected && (cardsToShow.filter { $0.isSelected }.count < 3) {
            cardsToShow[selectedCardIndex].isSelected = false
            cardsToShow[selectedCardIndex].matchingState = .unknown
            return
        }
        
        cardsToShow[selectedCardIndex].isSelected = true
        
        let numberOfSelectedCards = cardsToShow.filter { $0.isSelected }.count
        let selectedCards = cardsToShow.filter { $0.isSelected }
        
        if numberOfSelectedCards == 1 || numberOfSelectedCards == 2 {
            // change matching state the selected card to unknown
            cardsToShow[selectedCardIndex].matchingState = .unknown
            
        } else if numberOfSelectedCards == 3 {
            // if is Set - change matching state all selected cards to success
            // else - change matching state all selected cards to not success
            if isSet(selectedCards: selectedCards) {
                for i in 0..<cardsToShow.count {
                    if cardsToShow[i].isSelected {
                        cardsToShow[i].matchingState = .success
                    }
                }
            } else {
                for i in 0..<cardsToShow.count {
                    if cardsToShow[i].isSelected {
                        cardsToShow[i].matchingState = .notSuccess
                    }
                }
            }
        }
            
        if numberOfSelectedCards == 4 {
//            replaceThreeMatchedCards()
            deselect()
            cardsToShow[selectedCardIndex].isSelected = true
        }
    }
        
    
    private func deselect() {
        for index in 0..<cardsToShow.count {
            cardsToShow[index].isSelected = false
            cardsToShow[index].matchingState = .unknown
        }
    }
    
    private func replaceThreeMatchedCards() {
        let newThreeCards = dealThreeCards()
        if cardsToShow.count + newThreeCards.count > 81 {
            return
        }
        
        let selectedCards = cardsToShow.filter(\.isSelected)

        if isSet(selectedCards: selectedCards) {
            for (index, card) in cardsToShow.enumerated() where card.isSelected {
                cardsToShow[index] = newThreeCards[selectedCards.firstIndex(of: card)!]
            }
        }
    }
    
    private func isSet(selectedCards: [CardModel]) -> Bool {
        let shapes = selectedCards.map { $0.shapes }
        let numberOfShapes = selectedCards.map { $0.numberOfShapes }
        let colours = selectedCards.map { $0.colours }
        let shading = selectedCards.map { $0.shading }
        
        let numberOfUniqueShapes = Set(shapes).count
        let numberOfUniqueNumberOfShapes = Set(numberOfShapes).count
        let numberOfUniqueColours = Set(colours).count
        let numberOfUniqueShading = Set(shading).count
        
        if (numberOfUniqueShapes == 1 || numberOfUniqueShapes == 3) 
//            (numberOfUniqueNumberOfShapes == 1 || numberOfUniqueNumberOfShapes == 3) &&
//            (numberOfUniqueColours == 1 || numberOfUniqueColours == 3)
//            (numberOfUniqueShading == 1 || numberOfUniqueShading == 3)
        {
            return true
        }
        
        return false
    }
    
    
    
    private func random(_ count: Int, from cards: Set<CardModel>) -> [CardModel] {
        var localCards = cards
        var result: [CardModel] = []
        for _ in 1...count {
            if let randomCard = localCards.randomElement() {
                
                result.append(randomCard)
                localCards.remove(randomCard)
            }
            
        }
        return result
    }
    
    
}


