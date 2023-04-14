//
//  File.swift
//  SetGame
//
//  Created by Maryia Karpava on 01/04/2023.
//

import Foundation


struct CardModel: Identifiable, Hashable {
    var isSelected = false
    var matchingState: MatchingStates = .unknown
    
    enum MatchingStates {
        case success
        case notSuccess
        case unknown
    }
    
    let shapes: String
    let numberOfShapes: Int
    let colours: String
    let shading: String
    
    let id = UUID()
}
