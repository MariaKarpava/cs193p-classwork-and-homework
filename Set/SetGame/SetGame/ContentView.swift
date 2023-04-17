//
//  ContentView.swift
//  SetGame
//
//  Created by Maryia Karpava on 01/04/2023.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: SetViewModel = SetViewModel()
    
    var body: some View {
        VStack {
            AspectVGrid(items: viewModel.cardsToShow, aspectRatio: 2/3, minWidth: 80) { card in
                CardView(card: card, viewModel: viewModel)
                    .padding(4)
            }
            
            HStack {
                Button {
                    viewModel.onDealCardsTapped()
                } label: {
                    Text("Deal Three More Cards")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.padding(.top)
                
                Button {
                    viewModel.onNewGameTapped()
                } label: {
                    Text("New Game")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.padding(.top)

            }
            
            Spacer()
            
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
            ZStack{
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.stroke(highlightColour(), lineWidth: 10)
                
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
            }.onTapGesture {
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
