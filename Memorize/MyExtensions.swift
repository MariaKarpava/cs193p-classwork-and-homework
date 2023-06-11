//
//  MyExtensions.swift
//  Memorize
//
//  Created by Maryia Karpava on 11/06/2023.
//

import Foundation
import SwiftUI


extension Theme {
    var uiColour: Color {
        switch self.colour {
        case "green":
            return .green
        case "red":
            return .red
        case "blue":
            return .blue
        case "yellow":
            return .yellow
        case "brown":
            return .brown
        case "orange":
            return .orange
        default:
            return .red
        }
    }
}

