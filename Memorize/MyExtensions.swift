//
//  MyExtensions.swift
//  Memorize
//
//  Created by Maryia Karpava on 11/06/2023.
//

import Foundation
import SwiftUI


//extension Theme {
//    var uiColour: Color {
//        switch self.colour {
//        case "green":
//            return .green
//        case "red":
//            return .red
//        case "blue":
//            return .blue
//        case "yellow":
//            return .yellow
//        case "brown":
//            return .brown
//        case "orange":
//            return .orange
//        default:
//            return .red
//        }
//    }
//}

extension Color {
    init(rgbaColor rgba: Theme.RGBAColor) {
        self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
    }
}

// Color ->(problem) CGColor -> UIColor -> get: red, green, blue, alpha -> RGBAColor
extension Theme.RGBAColor {
     init(color: Color) {
         var red: CGFloat = 0
         var green: CGFloat = 0
         var blue: CGFloat = 0
         var alpha: CGFloat = 0
         
         print("red 1: \(red)")
         
         if let cgColor = color.cgColor {
             UIColor(cgColor: cgColor).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
             print("red 2: \(red)")
         }
         
         print("red 3: \(red)")
         
         self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
     }
}


// UIColor -> get: red, green, blue, alpha -> RGBAColor
extension Theme.RGBAColor {
    init(color: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
}
