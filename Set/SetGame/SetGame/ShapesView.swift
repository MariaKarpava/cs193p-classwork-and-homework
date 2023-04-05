//
//  ShapesView.swift
//  SetGame
//
//  Created by Maryia Karpava on 02/04/2023.
//

import SwiftUI

protocol ConfigurableCard {
    func setColour(colour: Color)
}


struct Oval: View {
    var colour: Color
    
    var body: some View {
        Capsule().fill(colour)
    }
}


struct Diamond: View {
    var colour: Color
    
    var body: some View {
        DiamondShape().fill(colour)
    }
    
    private struct DiamondShape: Shape {
        func path(in rect: CGRect) -> Path {
            Path() { p in
                p.move(to: CGPoint(x: rect.midX, y: rect.minY))
                p.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
                p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
                p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
                p.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
                p.closeSubpath()
            }
        }
    }
}


struct Square: View {
    var colour: Color
    
    var body: some View {
        Rectangle()
            .fill(colour)
    }
}
















//struct ShapesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShapesView()
//    }
//}
