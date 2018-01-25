//
//  Card.swift
//  Set
//
//  Created by Cole Turner on 1/14/18.
//  Copyright © 2018 Cole Turner. All rights reserved.
//

import Foundation
import UIKit

class Card: CustomStringConvertible {
    
    //initialization of variables, some are out of date and need to be removed
    var description: String {return "\(self.color) - \(self.number) - \(self.shape) - \(self.cardAlpha)"}
    lazy var alpha: CGFloat = cardAlpha.rawValue
    var isFaceUp = false
    var selected = false
    public var identifier: Int
    var shape: Shape
    var color: Color
    var cardAlpha: CardAlpha
    var number: Number
    var cardColor = UIColor.green
    var partOfSet = false
    static var identifierFactory = 0
    
    //enums for the different methods to draw
    enum Shape: String {

        case diamond = "diamond"
        case oval = "oval"
        case squiggle = "squiggle"

        static var all = [Shape.diamond, .oval, .squiggle]
        var description: String { return rawValue}
    }

    enum Color: String {
        case green = "green"
        case red
        case blue

        static var all = [Color.green, .red, .blue]
    }

    enum CardAlpha: CGFloat {
        case full = 1.0
        case semi = 0.20
        case minor = 0.0

        static var all = [CardAlpha.full, .semi, .minor]

    }

    enum Number: Int {
        case one = 1
        case two
        case three

        static var all = [Number.one, .two, .three]
    }
    

    //gets a unique identifier for the card
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    //initialization of the card brains
    init(geometry: Shape, look: Color, shade: CardAlpha, num: Number) {
        self.identifier  = Card.getUniqueIdentifier()
        self.shape = geometry
        self.color = look
        self.cardAlpha = shade
        self.number = num
        print(description)
    }
}
