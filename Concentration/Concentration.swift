//
//  Concentration.swift
//  Concentration
//
//  Created by Cole Turner on 1/9/18.
//  Copyright © 2018 Cole Turner. All rights reserved.
//

import Foundation

struct Concentration{
    
    //load an array of cards
    private(set) var cards = [Card]()
    
    var flipCount = 0 //{
//        didSet {
            let attributes: [NSAttributedStringKey:Any] = [
                .strokeWidth : 5.0,
                .strokeColor : (red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            ]
//            let attributedString = NSAttributedString(string: , attributes: )
//        }
//    }
    var scoreCount = 0
    
   private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    //when you click the card at a certain index
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index),"Concentration.chooseCard(at: \(index)): you must have at least one pair of cards.")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    //three because otherwise it would only give you one as it took 1 away for already 'seeing it'
                    scoreCount+=3
                }
                
                if cards[index].hasBeenSeen {
                    scoreCount-=1
                }
                flipCount+=1
                cards[index].isFaceUp = true
                cards[index].hasBeenSeen = true

            } else {
                //either no cards or 2 cards are face up
                if cards[index].hasBeenSeen {
                    scoreCount-=1
                }
                flipCount+=1
                indexOfOneAndOnlyFaceUpCard = index
                cards[index].hasBeenSeen = true
            }
        }
    }
    
    
    
    //add emoji themes here
   private(set) var emojiChoices = [
                         "sportEmojis": ["🏀","⚽️","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","⛸","⛷","🏹"],
                         "animalEmojis": ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮"],
                         "faceEmojis": ["😀","😃","😄","😁","😆","😅","😂","🤣","☺️","😊","😇","🙂"],
                         "foodEmojis": ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍒","🍑"],
                         "flagEmojis": ["🏳️","🏴","🏁","🏳️‍🌈","🇦🇫","🇦🇽","🇩🇿","🇦🇸","","🇦🇮","🇦🇶","🇺🇸"],
                         "symbolEmojis": ["➡️","⬅️","⬆️","⬇️","↗️","↘️","↙️","↖️","⏺","⏹","🔀","🔁"]]

    
    //randomly chooses a theme
    private lazy var randomNum = Int(arc4random_uniform(UInt32(emojiChoices.count)))
    private lazy var emojiChoiceForTheme = Array(emojiChoices.values)[randomNum]

    public var emojis = [Card:String]()
    
    
    //Choose emojis
    public mutating func emoji(for card: Card) -> String {
        if emojis[card] == nil, emojiChoiceForTheme.count > 0 {
            emojis[card] = emojiChoiceForTheme.remove(at:emojiChoiceForTheme.count.arc4random)
        }

        return emojis[card] ?? "?"
    }
    

    
    
    
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
            
        }
        shuffleCards()
        
    }
    
    //shuffle the cards
    mutating private func shuffleCards() {
        var cardsShuffled = [Card]()
        for _ in cards {
            let randomNum = Int(arc4random_uniform(UInt32(cards.count)))
            
            cardsShuffled.append(cards[randomNum])
            cards.remove(at: randomNum)
        }
        
        cards = cardsShuffled
    }
    
}


extension Int {
    var arc4random: Int {
        if self > 0 {
            return  Int(arc4random_uniform(UInt32(self)))
            
        } else if  self < 0 {
            return  -Int(arc4random_uniform(UInt32(abs(self))))
            
        } else {
            return 0
        }
}
}

extension Collection {
    var oneAndOnly: Element?
    {
        return count == 1 ? first : nil
    }
}
