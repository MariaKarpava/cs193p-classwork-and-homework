//
//  File.swift
//  SetGame
//
//  Created by Maryia Karpava on 01/04/2023.
//

import Foundation


struct CardModel: Identifiable, Hashable {
    var isSelected: Bool = false
    
    let shapes: String
    let numberOfShapes: Int
    let colours: String
    let shading: String
    
    let id = UUID()
}
