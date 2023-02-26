//
//  ContentView.swift
//  Memorize
//
//  Created by Maryia Karpava on 20/02/2023.
//

import SwiftUI


struct ContentView: View {
    @ State var emojis = ["🐶", "🐭", "🦊", "🐻", "🐼", "🐸", "🐵", "🐥", "🦄", "🐰", "🐷"]
    
    @ State var animalsEmojis = ["🐶", "🐭", "🦊", "🐻", "🐼", "🐸", "🐵", "🐥", "🦄", "🐰", "🐷"]
    
    @ State var vehicleEmojis = ["✈️", "🚁", "🚘", "🚃", "🚇", "🚛", "🛳️", "🚲", "🛴", "🚜", "🚒", "🛺", "🚂", "🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚐", "🛻", "🚚"]
    
    var houseEmojis = ["🛁", "🛏️", "🔑", "🪑", "🧸", "🖼️", "🪞", "🚽", "🛋️"]
    
    @State var emojiCount = 6
    
    @State var animalsCount = 11
    @State var vehicleCount = 24
    @State var houseCount = 9
    
    private func widthThatBestFits(cardCount: Int) -> CGFloat {
        if cardCount == 4 {
            return 175
        } else if cardCount >= 5 && cardCount < 9 {
            return 110
        } else if cardCount >= 10 && cardCount < 17 {
            return 70
        }
        return 65
    }

    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: emojiCount), maximum: 180))]) {
                    
                    ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })
                    
                }
            }
            .foregroundColor(.red)
             Spacer()
            HStack {
                Spacer()
                animalsButton
                Spacer()
                houseButton
                Spacer()
                vehiclesButton
                Spacer()
            }
            .font(.largeTitle)
            //.padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    
    // Buttons:
    var animalsButton: some View {
        Button {
            let random = Int.random(in: 4...animalsCount)
            emojiCount = random
            emojis = animalsEmojis.shuffled()
        } label: {
            VStack {
                Image(systemName: "pawprint")
                Text("Animals")
                    .font(.system(size: 18.0))
            }
        }
    }

    var vehiclesButton: some View {
        Button {
            let random = Int.random(in: 4...vehicleCount)
            emojiCount = random
            emojis = vehicleEmojis.shuffled()
            
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles")
                    .font(.system(size: 18))
            }
        }
    }
    
    var houseButton: some View {
        Button {
            let random = Int.random(in: 4...houseCount)
            emojiCount = random
            emojis = houseEmojis.shuffled()
        } label: {
            VStack {
                Image(systemName: "house")
                Text("House")
                    .font(.system(size: 18))
            }
        }
    }
}


struct CardView: View {
    var content:String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture{
            isFaceUp = !isFaceUp
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}

