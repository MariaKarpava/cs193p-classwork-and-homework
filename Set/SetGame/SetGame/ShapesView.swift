//
//  ShapesView.swift
//  SetGame
//
//  Created by Maryia Karpava on 02/04/2023.
//

import SwiftUI

struct Oval: View, ConfigurableCard {
    
    func addColor() -> some View {
        self.opacity(0.4)
    }
    
    var body: some View {
        Capsule()
            .fill(.red)
    }
}


struct Diamond: Shape {
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


struct Square: View {
    var body: some View {
        Rectangle()
            .fill(.red)
    }
}


protocol ConfigurableCard {
//    func addColor() -> some View
//    func stripe()
//    func addTransparency()
}















//struct ShapesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShapesView()
//    }
//}
