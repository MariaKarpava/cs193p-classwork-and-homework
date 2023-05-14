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
    
    @State private var shouldBeDisplayedInGrid: Set<Int> = Set<Int>()
    
    var deckView: some View {
        ZStack {
            ForEach(Array(viewModel.cardDeck.cards)) { card in
                // TODO: ???
                CardView(card: card, viewModel: viewModel)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            }
        }
        .frame(width: 90 * 2/3, height: 90)
        .foregroundColor(Color.red)
    }
    
    
    var body: some View {
        VStack {
            AspectVGrid(items: viewModel.cardsToShow, aspectRatio: 2/3, minWidth: 80) { card in
                if shouldBeDisplayedInGrid.contains(card.id) {
                    CardView(card: card, viewModel: viewModel)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .padding(4)
                }
            }
            Spacer()
            deckView
            Spacer()
            HStack {
                Button {
                    withAnimation {
                        viewModel.onDealCardsTapped()
                    }
                    allowCardsToBeDisplayedOneByOne()
                } label: {
                    Text("Deal Three More Cards")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }.padding(.top)
                    .disabled(viewModel.isButtonDisabled)
                    .opacity(viewModel.isButtonDisabled ? 0.6 : 1)
                
                Button {
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
    
    private func allowCardsToBeDisplayedOneByOne() {
        var delay = 0.0
        for c in viewModel.cardsToShow {
            if shouldBeDisplayedInGrid.contains(c.id) { continue }
            withAnimation(.default.delay(delay)) {
                _ = shouldBeDisplayedInGrid.insert(c.id)
            }
            delay += 0.1
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
    

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.stroke(highlightColour(), lineWidth: 6)
                
                shape.foregroundColor(.white)
                
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
                
            }.rotation3DEffect(
                Angle.degrees(card.spin ? 360 : 0),
                axis: (0, 1, 0)
            ).animation(.linear(duration: 2.0).repeatForever(autoreverses: false), value: card.spin)
            .onTapGesture {
                viewModel.onCardSelected(cardId: card.id)
            }
        }
    }
}
 




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
