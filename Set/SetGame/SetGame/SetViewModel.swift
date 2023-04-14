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
    var allCards = Set(CardsFactory.createCards())
    

    private func dealThreeCards() -> [CardModel] {
        var threeCards:[CardModel] = []
        
        for _ in 0..<3 {
            if let randomCard = allCards.randomElement() {
                threeCards.append(randomCard)
                allCards.remove(randomCard)
            }
        }
        return threeCards
    }
        
    func onDealCardsTapped() {
        let newThreeCards = dealThreeCards()
        if cardsToShow.count + newThreeCards.count > 81 {
            return
        }
        cardsToShow.append(contentsOf: newThreeCards)
    }
    
    func onNewGameTapped() {
        allCards = generateAllPossibleCards()
        cardsToShow = random(12, from: allCards)
        cardsToShow.forEach { allCards.remove($0) }
    }
    
    
  
    func onCardSelected(cardId: UUID) {
        guard let selectedCardIndex = cardsToShow.firstIndex(where: { $0.id == cardId }) else {
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
            deselect()
            cardsToShow[selectedCardIndex].isSelected = true 
        }
            
        
    }
        
    
    func deselect() {
        for index in 0..<cardsToShow.count {
            cardsToShow[index].isSelected = false
            cardsToShow[index].matchingState = .unknown
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
    
    
    private func generateAllPossibleCards() -> Set<CardModel> {
        return Set(CardsFactory.createCards())
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


