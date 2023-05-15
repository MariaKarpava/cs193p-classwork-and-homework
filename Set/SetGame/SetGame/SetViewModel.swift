//
//  SetViewModel.swift
//  SetGame
//
//  Created by Maryia Karpava on 10/04/2023.
//

import Foundation
/*
TODO:
 1. When any card is touched on and there are already 3 matching Set cards selected,
 then …
 b. if the deck is empty then the space vacated by the matched cards (which cannot be
 replaced since there are no more cards) should be made available to the remaining
 cards (i.e. which may well then get bigger)
*/


// TODO: restrict access as much as possible to members
class SetViewModel: ObservableObject {
    
    @Published var cardsToShow: [CardModel] = []
    var cardDeck = CardDeck()
    var isButtonDisabled: Bool {
        if cardDeck.cards.count == 0 || cardDeck.cards.count == 81 {
            return true
        } else {
            return false
        }
    }
    
    private func dealThreeCards() -> [CardModel] {
        var threeCards:[CardModel] = []
        
        for _ in 0..<3 {
            if let randomCard = cardDeck.cards.randomElement() {
                threeCards.append(randomCard)
                
                if let index = cardDeck.cards.firstIndex(where: { $0.id == randomCard.id }) {
                    cardDeck.cards.remove(at: index)
                }
            }
        }
        return threeCards
    }
        
    func onDealCardsTapped() {
        var newThreeCards = dealThreeCards()
        if cardsToShow.count + newThreeCards.count > 81 {
            return
        }
        
        // if already selected 3 cards create set - replace these 3 cards with new ones
        // else - add 3 new cards to the end
        let selectedCards = cardsToShow.filter { $0.isSelected }
        if isSet(selectedCards: selectedCards) {
            for (i, card) in cardsToShow.enumerated() where card.isSelected {
                if let last = newThreeCards.last {
                    cardsToShow[i] = last
                    newThreeCards.removeLast()
                }
            }
        } else {
            cardsToShow += newThreeCards
        }
    }
    
    func onNewGameTapped() {
        cardsToShow = []
        cardDeck = CardDeck()
        cardDeck.cards.shuffle()

        for _ in 0..<12 {
            if let last = cardDeck.cards.last {
                cardsToShow.append(last)
                cardDeck.cards.removeLast()
            }
        }
    }
    

    /*
     
       stack 1    stack 2
     A:  []       [1 2 3]
     B:  [3]      [1 2]
     
     Animate A -> B
        1). create new CardView for id 3 and add to stack 1
        2). delete CardView with id 3 from stack 2
        Note: given matchedGeometryEffect is configured on both views and ids match and namespace match => apply "fly" animation
    
     */
    
    
    /*
     
       stack 1    stack 2
     A:  []       [a b c]
     B:  [z]      [x y]
     
     Animate A -> B
        - ids don't match! not "fly" :(
     
     */
  
    func onCardSelected(cardId: Int) {
        guard let selectedCardIndex = cardsToShow.firstIndex(where: { $0.id == cardId }) else {
            return
        }
        
        var selectedCards = cardsToShow.filter { $0.isSelected }
        // Support “deselection” by touching already-selected cards (but only if there are 1 or 2
        // cards (not 3) currently selected).
        let selectedCard = cardsToShow[selectedCardIndex]
        if selectedCard.isSelected && (cardsToShow.filter { $0.isSelected }.count < 3) {
            cardsToShow[selectedCardIndex].isSelected = false
            cardsToShow[selectedCardIndex].matchingState = .unknown
            return
        } else if selectedCard.isSelected && (cardsToShow.filter { $0.isSelected }.count == 3) && !isSet(selectedCards: selectedCards) {
            for i in 0..<cardsToShow.count {
                if cardsToShow[i].isSelected {
                    cardsToShow[i].isSelected = false
                    cardsToShow[i].matchingState = .notSuccess
                }
            }
            cardsToShow[selectedCardIndex].isSelected = true
            cardsToShow[selectedCardIndex].matchingState = .unknown
            return
        }
        
        cardsToShow[selectedCardIndex].isSelected = true
        
        let numberOfSelectedCards = cardsToShow.filter { $0.isSelected }.count
        selectedCards = cardsToShow.filter { $0.isSelected }
        
        
        
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
            cardsToShow[selectedCardIndex].isSelected = false
            selectedCards = cardsToShow.filter { $0.isSelected }
            
            replaceThreeMatchedCards()
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
        var newThreeCards = dealThreeCards()
        if cardsToShow.count + newThreeCards.count > 81 {
            return
        }
        let selectedCards = cardsToShow.filter { $0.isSelected }
        if isSet(selectedCards: selectedCards) {
            for (i, card) in cardsToShow.enumerated() where card.isSelected {
                if let last = newThreeCards.last {
                    cardsToShow[i] = last
                    newThreeCards.removeLast()
                }
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
        
        if (numberOfUniqueShapes == 1 || numberOfUniqueShapes == 3) &&
            (numberOfUniqueNumberOfShapes == 1 || numberOfUniqueNumberOfShapes == 3) &&
            (numberOfUniqueColours == 1 || numberOfUniqueColours == 3) &&
            (numberOfUniqueShading == 1 || numberOfUniqueShading == 3)
        {
            return true
        }
        
        return false
    }
    
    
    
    private func random(_ count: Int, from cards: [CardModel]) -> [CardModel] {
        var localCards = cards
        localCards.shuffle()
        let result = Array(localCards[0..<count])
        return result
    }
}


