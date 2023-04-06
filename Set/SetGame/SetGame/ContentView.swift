//
//  ContentView.swift
//  SetGame
//
//  Created by Maryia Karpava on 01/04/2023.
//


import SwiftUI

struct ContentView: View {
    @State private var cardsToShow: [CardModel] = []
    
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
    
    
    var body: some View {
        VStack {
            AspectVGrid(items: cardsToShow, aspectRatio: 2/3, minWidth: 80) { card in
                CardView(card: card)
                    .padding(4)
            }
            
            HStack {
                Button {
                    let newCards = dealThreeCards()
                    if cardsToShow.count + newCards.count > 81 {
                        return
                    }
                    cardsToShow.append(contentsOf: newCards)
                } label: {
                    Text("Deal Three More Cards")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.padding(.top)
                
                Button {
                    let newCards = dealTwelveCards()
                    cardsToShow.append(contentsOf: newCards)
                    
                    if cardsToShow.count >= 12 {
                        cardsToShow = []
                        let newCards = dealTwelveCards()
                        cardsToShow.append(contentsOf: newCards)
                    }
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




// TODO: make sure *Model types know nothing about View-layer (SwiftUI). Hint: you draw views based on models.
struct CardModel: Identifiable, Hashable {
    var isSelected: Bool = false
    
    let shapes: String
    let numberOfShapes: Int
    let colours: String
    let shading: String
    
    let id = UUID()
    
}


struct CardsFactory {
    static func createCards() -> [CardModel] {
        var allCards:[CardModel] = []
        
        let shapes = ["diamond", "oval", "square"]
        let numberOfShapes = [1, 2, 3]
        let colours = ["red", "green", "purple"]
        let shading = ["solid", "semi-transparent", "outlined"]
    
        
        for shape in shapes {
            for number in numberOfShapes {
                for colour in colours {
                    for shade in shading {
                        let card = CardModel(shapes: shape, numberOfShapes: number, colours: colour, shading: shade)
                        allCards.append(card)
                    }
                }
            }
        }
        return allCards
    }
}


struct CardView: View {
    var card: CardModel
    var allCards = CardsFactory.createCards()
    
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
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.stroke(.red, lineWidth: 3)
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
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
