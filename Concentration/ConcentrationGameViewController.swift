//
//  ViewController.swift
//  Concentration
//
//  Created by Cole Turner on 1/9/18.
//  Copyright © 2018 Cole Turner. All rights reserved.
//

import UIKit

class ConcentrationGameViewController: UIViewController {
    
    //load in a new game
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
     var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1)/2
    }
    
    var theme:[String] = []// {
//        didSet {
//            game.cards.forEach(){
//                $0.isFaceUp = false
//
//            }
//        }
//    }

    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreCounter: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    //runs the new game code
    @IBAction func newGame(_ sender: Any) {
        let newFunGame = Concentration(numberOfPairsOfCards:(cardButtons.count+1)/2)
        for index in cardButtons.indices {
            var card = game.cards[index]
            card.isFaceUp = false
            updateViewFromModel()
        }
        game = newFunGame
        game.flipCount = 0
        loadView()
    }
    
    
    
    
    //what happens when you touch a card
    @IBAction func touchCard(_ sender: UIButton) {
        
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("The chosen card was not in cardButtons.")
        }
    }
    
    //update the view
    func updateViewFromModel() {
        game.emojiChoiceForTheme = theme
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let cardOfChoice = game.cards[index]
            if cardOfChoice.isFaceUp {
                button.setTitle(game.emoji(for: cardOfChoice), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = cardOfChoice.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreCounter.text = "Score: \(game.scoreCount)"
    }
    
}

