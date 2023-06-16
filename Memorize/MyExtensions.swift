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
         
         // print("red 1: \(red)")
         
         if let cgColor = color.cgColor {
             UIColor(cgColor: cgColor).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
             // print("red 2: \(red)")
         }
         
         // print("red 3: \(red)")
         
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




// some extensions to String and Character
// to help us with managing our Strings of emojis
// we want them to be "emoji only"
// (thus isEmoji below)
// and we don't want them to have repeated emojis
// (thus withoutDuplicateCharacters below)

extension String {
    var removingDuplicateCharacters: String {
        reduce(into: "") { sofar, element in
            if !sofar.contains(element) {
                sofar.append(element)
            }
        }
    }
}



extension Array where Element == String {
    var removingDuplicateStrings: [String] {
        var uniqueElements: [String] = []
        var seenElements: Set<String> = []
        
        for element in self {
            if !seenElements.contains(element) {
                uniqueElements.append(element)
                seenElements.insert(element)
            }
        }
        return uniqueElements
    }
}



extension Character {
    var isEmoji: Bool {
        // Swift does not have a way to ask if a Character isEmoji
        // but it does let us check to see if our component scalars isEmoji
        // unfortunately unicode allows certain scalars (like 1)
        // to be modified by another scalar to become emoji (e.g. 1️⃣)
        // so the scalar "1" will report isEmoji = true
        // so we can't just check to see if the first scalar isEmoji
        // the quick and dirty here is to see if the scalar is at least the first true emoji we know of
        // (the start of the "miscellaneous items" section)
        // or check to see if this is a multiple scalar unicode sequence
        // (e.g. a 1 with a unicode modifier to force it to be presented as emoji 1️⃣)
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}


extension String {
    var emojiArray: [String] {
        var emojis: [String] = []
        for char in self {
            if char.isEmoji {
                emojis.append(String(char))
            }
        }
        return emojis
    }
}
