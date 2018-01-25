//
//  Card.swift
//  Concentration
//
//  Created by Cole Turner on 1/9/18.
//  Copyright © 2018 Cole Turner. All rights reserved.
//

import Foundation


struct CardForConcentration: Hashable
{
    var hashValue: Int { return identifier}
    
    static func ==(lhs: CardForConcentration, rhs: CardForConcentration) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var hasBeenSeen = false
    private var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier  = CardForConcentration.getUniqueIdentifier()
    }
}
