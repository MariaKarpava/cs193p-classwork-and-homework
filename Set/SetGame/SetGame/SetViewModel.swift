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
    
    private func generateAllPossibleCards() -> Set<CardModel> {
        return Set(CardsFactory.createCards())
    }
    
    private func random(_ count: Int, from cards: Set<CardModel>) -> [CardModel] {
        var result: [CardModel] = []
        for _ in 1...count {
            if let randomCard = cards.randomElement() {
                result.append(randomCard)
            }
        }
        return result
    }
}


