//
//  ShapesView.swift
//  SetGame
//
//  Created by Maryia Karpava on 02/04/2023.
//

import SwiftUI

struct Oval: View {
    var body: some View {
        Capsule()
            .fill(.red)
            .frame(width: 80, height: 40)
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
            .frame(width: 80, height: 40)
    }
}



struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY*1/3))
        
        return path
    }
 
}



//struct ShapesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShapesView()
//    }
//}
