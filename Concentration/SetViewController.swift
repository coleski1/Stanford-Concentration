//
//  ViewController.swift
//  Set
//
//  Created by Cole Turner on 1/13/18.
//  Copyright © 2018 Cole Turner. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    //init
    private var game = Set()
    var index = 0
    lazy var grid = Grid(layout: Grid.Layout.aspectRatio(5/8), frame: mainView.bounds)
    private var selectedCards = [CardView]()
    @IBOutlet weak var scoreCounter: UILabel!
    
    //the big background view that the grid is written onto
    @IBOutlet weak var mainView: MainView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(onDrawCardsSwipe(_:)))
            swipe.direction = [.down]
            mainView.addGestureRecognizer(swipe)
            mainView.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(onReShuffleCards(_:))))
            dealCards()
            updateViewFromModel()
        }
    }
    
    //for the newGame button
    @IBAction func newGame(_ sender: UIButton) {
        game.cardsOnTable.forEach {
            $0.removeFromSuperview()
        }
        game.cardsOnTable.removeAll()
        game = Set()

        game.score = 0
        dealCards()
        updateViewFromModel()
    }

    //for the deal three more button
    @IBAction func dealThreeMore(_ sender: UIButton) {
       outsideDealThreeMore()
    }
    
    //when swiping down draw three more cards on the screen
    @objc func onDrawCardsSwipe(_ recognizer: UISwipeGestureRecognizer) {
        outsideDealThreeMore()
    }
    
    //reshuffle the cards on the screen
    @objc func onReShuffleCards(_ recognizer : UIRotationGestureRecognizer) {
        if recognizer.state == .ended {
            var cardsShuffled = [CardView]()
            for _ in game.cardsOnTable {
                let randomNum = Int(arc4random_uniform(UInt32(game.cardsOnTable.count)))
                
                cardsShuffled.append(game.cardsOnTable[randomNum])
                game.cardsOnTable[randomNum].removeFromSuperview()
                game.cardsOnTable.remove(at: randomNum)
                
            }
            
            game.cardsOnTable = cardsShuffled
            game.cardsOnTable.forEach {
                mainView.addSubview($0)
            }
            updateViewFromModel()
            
        }
    }
    
    //updates the view of the game
    public func updateViewFromModel() {
        for index in game.cardsOnTable.indices {
            let insetXY = (grid[index]?.height ?? 400)/100
            game.cardsOnTable[index].frame = grid[index]?.insetBy(dx: insetXY, dy: insetXY) ?? CGRect.zero
        }
        if scoreCounter != nil {scoreCounter.text! = "Score: \(game.score)"}
    }
    
    //deals all the cards needed at the beginning
    private func dealCards() {
        for _ in 0...3 {
            outsideDealThreeMore()
        }
    }
    
    //deals 3 random cards
    private func outsideDealThreeMore() {
        if game.cards.count > 2 {
            let tableCount = game.cardsOnTable.count + 2
            
            for index in game.cardsOnTable.count...game.cardsOnTable.count + 2 {
                game.cards[tableCount - index].isFaceUp = true
                game.cardsOnTable.append(CardView())
                game.cardsOnTable[index].color = game.cards[tableCount - index].color.rawValue
                game.cardsOnTable[index].cardAlpha = game.cards[tableCount - index].cardAlpha.rawValue
                game.cardsOnTable[index].number = game.cards[tableCount - index].number.rawValue
                game.cardsOnTable[index].shape = game.cards[tableCount - index].shape.rawValue
                grid.cellCount = game.cardsOnTable.count
                game.cardsOnTable[index].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseCard)))
                
                mainView.addSubview(game.cardsOnTable[index])
            }
            for index in 0...2 {
                game.cards.remove(at: 2 - index)
            }
        }
        
        updateViewFromModel()
    }
    var tempChosenCards = [CardView]()
    
    //chooses the card that was clicked on
    @objc func chooseCard(_ recognizer: UITapGestureRecognizer) {
        guard let tappedCard = recognizer.view as? CardView else { return }
        tempChosenCards.append(tappedCard)
        let cardIndex = game.cardsOnTable.index(of: tappedCard)
        print(tappedCard.borderSelect)
        if tappedCard.borderSelect == false {
            tappedCard.borderSelect = true
            tappedCard.layer.borderWidth = 5.0
            tappedCard.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        } else {
            tempChosenCards.remove(at: tempChosenCards.index(of: tappedCard)!)
            tappedCard.layer.borderWidth = 0
            tappedCard.borderSelect = false
        }
        game.chooseCard(at: cardIndex!)
        if game.isSet == true || tempChosenCards.count == 3{
            if game.isSet == true {
                tempChosenCards.forEach {
                    $0.removeFromSuperview()
                }
                outsideDealThreeMore()
                game.isSet = false
            } else if tempChosenCards.count == 3 && game.isSet==false{
                tempChosenCards.forEach {
                    $0.layer.borderWidth = 0
                }
                tempChosenCards.removeAll()
            }
        }
        updateViewFromModel()
    }
}

struct LayOutMetricsForCardView {
    static var borderWidth: CGFloat = 1.0
    static var borderWidthIfSelected: CGFloat = 4.0
    static var borderColorIfSelected: CGColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1).cgColor

    static var borderWidthIfHinted: CGFloat = 4.0
    static var borderColorIfHinted: CGColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1).cgColor

    static var borderWidthIfMatched: CGFloat = 4.0
    static var borderColorIfMatched: CGColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).cgColor

    static var borderColor: CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    static var borderColorForDrawButton: CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    static var borderWidthForDrawButton: CGFloat = 3.0
    static var cornerRadius: CGFloat = 8.0
}
//creates a random integer, from lecture code
//extension Int {
//    var arc4random: Int {
//        if self > 0 {
//            return  Int(arc4random_uniform(UInt32(self)))
//            
//        } else if  self < 0 {
//            return  -Int(arc4random_uniform(UInt32(abs(self))))
//            
//        } else {
//            return 0
//        }
//    }
//}


