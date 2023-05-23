//
//  ShapesView.swift
//  SetGame
//
//  Created by Maryia Karpava on 02/04/2023.
//

import SwiftUI


struct Oval: View {
    var colour: Color
    var opacity: Double
    
    var body: some View {
        Capsule()
            .fill(colour)
            .opacity(opacity)
            .overlay(
                        Capsule()
                            .stroke(colour, lineWidth: 2)
                    )
    }
}


struct Diamond: View {
    var colour: Color
    var opacity: Double
    
    var body: some View {
        DiamondShape()
            .fill(colour)
            .opacity(opacity)
            .overlay(
                        DiamondShape()
                            .stroke(colour, lineWidth: 2)
                    )
        
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
    var opacity: Double
    
    var body: some View {
        Rectangle()
            .fill(colour)
            .opacity(opacity)
            .overlay(
                        Rectangle()
                            .stroke(colour, lineWidth: 2)
                    )
    }
}
















//struct ShapesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShapesView()
//    }
//}
