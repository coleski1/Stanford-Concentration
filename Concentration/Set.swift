//
//  Set.swift
//  Set
//
//  Created by Cole Turner on 1/14/18.
//  Copyright © 2018 Cole Turner. All rights reserved.
//

import Foundation
import UIKit
class Set {
    
    //array of cards that were chosen so I can match sets
    var chosenCards:[CardView] = []
    var score = 0
    //array of all the cards
    public var cards = [Card]()
    //array of cardviews that are being able to be seen on the screen at once
    public var cardsOnTable = [CardView]()
    var isSet = false
    
    //matches cards but definitely bloated and needs some work
    func chooseCard(at index: Int) {
        if cardsOnTable[index].selected == true {
            cardsOnTable[index].selected = false
            for pleaseCheck in 0...chosenCards.count {
                print("cards on table: \(cardsOnTable.count)")
                print("chosenCards count: \(chosenCards.count)")
                print("pleaseCheck value: \(pleaseCheck)")
                if chosenCards[pleaseCheck].hashValue == cardsOnTable[index].hashValue {
                    chosenCards.remove(at: pleaseCheck)
                    break
                }
            }
        } else if(chosenCards.count<3) {
            chosenCards.append(cardsOnTable[index])
            cardsOnTable[index].selected = true
        }
        
        if chosenCards.count==3{
            let card0 = chosenCards[0]
            let card1 = chosenCards[1]
            let card2 = chosenCards[2]
            
            print("cardColor: \(card0.color) \(card1.color) \(card2.color)")
            
            if ((card0.color == card1.color && card0.color == card2.color) || (card1.color != card2.color && card0.color != card1.color && card0.color != card2.color)) {
                print("made it past cardColor")
                
                if ((card0.number == card1.number && card0.number == card2.number)||(card0.number != card1.number && card0.number != card2.number && card1.number != card2.number)) {
                    
                    if((card0.alpha == card1.alpha && card0.alpha == card2.alpha)||((card1.alpha != card2.alpha  && card0.alpha != card1.alpha && card0.alpha != card2.alpha))) {
                        print("made it past the alpha")
                        
                        if ((card0.shape == card1.shape && card0.shape == card2.shape)||(card0.shape != card1.shape && card0.shape != card2.shape && card1.shape != card2.shape)) {
                            print("now through setTitle")
                            
                            for card in chosenCards {
                                card.partOfSet = true
                                card.isFaceUp = false
                                card.selected = false
                            }
                            score = score + 3
                            cardsOnTable.remove(at: cardsOnTable.index(of: card0)!)
                            cardsOnTable.remove(at: cardsOnTable.index(of: card1)!)
                            cardsOnTable.remove(at: cardsOnTable.index(of: card2)!)
                            
                            chosenCards.removeAll()
                            isSet = true
                        } else {
                           return  removeAllChosenCards()
                        }
                    } else {
                       return removeAllChosenCards()
                    }
                } else{
                    return removeAllChosenCards()
                }
            } else {
               return removeAllChosenCards()
            }
        }
    }
    
    private func removeAllChosenCards() {
        for card in chosenCards {
            card.selected = false
        }
        
        score = score - 5
        chosenCards.removeAll()
    }
    
    //gets one of each type to make 81
    init() {
        for num in Card.Number.all {
            for geometry in Card.Shape.all {
                for shade in Card.CardAlpha.all {
                    for look in Card.Color.all {
                        cards.append(Card(geometry: geometry, look: look, shade: shade, num: num))
                    }
                }
            }
        }
        
        shuffleCards()
    }
    
    //shuffle the cards
    private func shuffleCards() {
        var cardsShuffled = [Card]()
        for _ in cards {
            let randomNum = Int(arc4random_uniform(UInt32(cards.count)))
            
            cardsShuffled.append(cards[randomNum])
            cards.remove(at: randomNum)
        }
        
        cards = cardsShuffled
    }
}




