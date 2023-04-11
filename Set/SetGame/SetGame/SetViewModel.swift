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
        cardsToShow[selectedCardIndex].isCardSelected.toggle()
        
        
        let numberOfSelectedCards = cardsToShow.filter { $0.isCardSelected }.count
        if numberOfSelectedCards == 3 {
            for index in 0..<cardsToShow.count {
                cardsToShow[index].isCardSelected = false
            }
        }
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


