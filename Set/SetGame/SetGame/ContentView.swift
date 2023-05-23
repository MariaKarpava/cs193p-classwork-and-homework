//
//  ContentView.swift
//  SetGame
//
//  Created by Maryia Karpava on 01/04/2023.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: SetViewModel = SetViewModel()
    
    @Namespace private var dealingNamespace
    @Namespace private var discardingNamespace
    
    @State private var shouldBeDisplayedInGrid: Set<Int> = Set<Int>()
    
    
    
    private func cardsCurrentlyInDeck() -> [CardModel] {
        let cardsInDeck = viewModel.cardDeck.cards
            + viewModel.cardsToShow.reversed().filter { !shouldBeDisplayedInGrid.contains($0.id) }
        return cardsInDeck
    }
    

    var deckView: some View {
        ZStack {
            ForEach(cardsCurrentlyInDeck()) { card in
                let shape = RoundedRectangle(cornerRadius: 10)
                shape
                    .foregroundColor(.red)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: 90 * 2/3, height: 90)
        .onTapGesture {
            withAnimation {
                viewModel.onDealCardsTapped()
            }
            allowCardsToBeDisplayedOneByOne()
            allowCardsBeDiscardedOneByOne()
        }
    }
    
    

    var DiscardPileView: some View {
        ZStack {
            ForEach(viewModel.discardPile) { card in
                if !shouldBeDisplayedInGrid.contains(card.id) {
                    CardView(card: card, viewModel: viewModel)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .zIndex(zIndexForDiscardPile(of: card))
                }
            }
        }
        .frame(width: 90 * 2/3, height: 90)
        .foregroundColor(Color.pink)
    }
    
    
    
    private func zIndex(of card: CardModel) -> Double {
        Double(cardsCurrentlyInDeck().firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private func zIndexForDiscardPile(of card: CardModel) -> Double {
        Double(viewModel.discardPile.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    
    var body: some View {
        VStack {
            AspectVGrid(items: viewModel.cardsToShow, aspectRatio: 2/3, minWidth: 80) { card in
                if shouldBeDisplayedInGrid.contains(card.id) {
                    CardView(card: card, viewModel: viewModel)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .padding(4)
                        .zIndex(zIndex(of: card))
                        .onTapGesture {
                            withAnimation {
                                viewModel.onCardSelected(cardId: card.id)
                            }
                            allowCardsToBeDisplayedOneByOne()
                            allowCardsBeDiscardedOneByOne()
                        }
                } else {
                    // Even if we don't want to display a card based on its absence in shouldBeDisplayedInGrid, we still want to render the corresponding cell because, for ex, when 3 cards are being replaced, we never want the total count of cells being changed during this process.
                    Color.white
                }
            }
            if !viewModel.isButtonDisabled {
                Spacer()
                HStack {
                    Spacer()
                    DiscardPileView
                    Spacer()
                    deckView
                    Spacer()
                }
            }
            
            Spacer()
            HStack {

                Button {
                    shouldBeDisplayedInGrid = Set()
                    withAnimation {
                        viewModel.onNewGameTapped()
                    }
                    allowCardsToBeDisplayedOneByOne()
                } label: {
                    Text("New Game")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }.padding(.top)
            }
            
            
            
            Spacer()
            
        }
    }
    
//    private func delete3SelectedMatchedCards() -> Set<Int> {
//        for c in viewModel.threeMatchedCards {
//            shouldBeDisplayedInGrid.remove(c.id)
//        }
//        return shouldBeDisplayedInGrid
//    }
//
    
    private func allowCardsToBeDisplayedOneByOne() {
        var delay = 0.0
        for c in viewModel.cardsToShow {
            if shouldBeDisplayedInGrid.contains(c.id) { continue }
            withAnimation(.default.delay(delay)) {
                _ = shouldBeDisplayedInGrid.insert(c.id)
            }
            delay += 0.2
        }
    }
    
    
    private func allowCardsBeDiscardedOneByOne() {
        // delete cards that are in pile from shouldBeDisplayedInGrid
        var delay = 0.0
        for c in viewModel.discardPile {
            if shouldBeDisplayedInGrid.contains(c.id) {
                withAnimation(.default.delay(delay)) {
                    _ = shouldBeDisplayedInGrid.remove(c.id)
                }
                delay += 0.2
            }
        }
    }
}





struct CardView: View {
    let card: CardModel
    let viewModel: SetViewModel


    func mapColour() -> Color {
        var colour = Color.red
        switch card.colours {
        case "red":
            colour = .red
        case "green":
            colour = .green
        case "purple":
            colour = .purple
        default:
            colour = .black
        }
        return colour
    }
    
    func mapShading() -> Double {
        var opacity: Double = 0
        switch card.shading {
        case "solid":
            opacity = 1
        case "semi-transparent":
            opacity = 0.5
        case "outlined":
            opacity = 0
        default:
            opacity = 1
        }
        return opacity
    }
    
    
    func highlightColour() -> Color {
        var result = Color.blue
 
        if card.isSelected && card.matchingState == .success {
            result = .green
        } else if card.isSelected && card.matchingState == .notSuccess {
            result = .red
        } else if card.isSelected && card.matchingState == .unknown {
            result = .yellow
        }

        return result
    }
    
    
    
    private func backgroundColour(for state: CardModel.MatchingStates) -> Color {
        if state == .success {
            return Color.green.opacity(0.1)
        } else if state == .notSuccess {
            return Color.red.opacity(0.1)
        }
        return Color.white
    }
    

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.stroke(highlightColour(), lineWidth: 6)
                
                shape
                    .foregroundColor(backgroundColour(for: card.matchingState))
                    .animation(Animation.linear.speed(0.25), value: card.matchingState)
                

                VStack{
                    ForEach(0..<card.numberOfShapes, id: \.self) { _ in
                        
                        Group {
                            if card.shapes == "diamond" {
                                Diamond(colour: self.mapColour(), opacity: self.mapShading())
                            } else if card.shapes == "oval" {
                                Oval(colour: self.mapColour(), opacity: self.mapShading())
                            } else if card.shapes == "square" {
                                Square(colour: self.mapColour(), opacity: self.mapShading())
                            }
                        }.frame(width: geometry.size.width*0.3, height: geometry.size.width*0.3)
                        
                    }
                }
                
            }
        }
    }
}
 




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
