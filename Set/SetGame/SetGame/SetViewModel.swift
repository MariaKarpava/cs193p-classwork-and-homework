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
    
    func dealThreeCards() -> [CardModel] {
        var allCards = Set(CardsFactory.createCards())
        var threeCards:[CardModel] = []
        
        for _ in 0..<3 {
            if let randomCard = allCards.randomElement() {
                threeCards.append(randomCard)
                allCards.remove(randomCard)
            }
        }
        return threeCards
    }
    
    func dealTwelveCards() -> [CardModel] {
        var allCards = Set(CardsFactory.createCards())
        var threeCards:[CardModel] = []
        
        for _ in 0..<12 {
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
        let newTwelveCards = dealTwelveCards()
        cardsToShow.append(contentsOf: newTwelveCards)

        if cardsToShow.count >= 12 {
            cardsToShow = []
            let newTwelveCards = dealTwelveCards()
            cardsToShow.append(contentsOf: newTwelveCards)
        }
    }
    

}


