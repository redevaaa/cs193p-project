//
//  ViewController.swift
//  Concentration
//
//  Created by redevaaa on 2020/11/28.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfParisOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) ,
            .strokeWidth : 2,
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    func updateScoreLabel(){
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)  ,
            .strokeWidth : 2,
        ]
        let attributedString = NSAttributedString(string: "Scores: \(game.score)", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
    

    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card was not in cardButtons ")
        }
    }
    

    @IBAction func touchNewGame() {
        startNewGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
    
    private func startNewGame() {
        let emojiThemesKey = Array(emojiThemes.keys)
        emojiChoices = emojiThemes[emojiThemesKey[emojiThemesKey.count.randomNumber]]!
        emoji = [Card: String]()
        game = Concentration(numberOfParisOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        updateFlipCountLabel()
        updateScoreLabel()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    lazy private var emojiChoices = ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"]
    private var emojiThemes = [
        "fruits":["🥑", "🍍", "🍆", "🍠", "🍉", "🍇", "🥝", "🍒"],
        "animals":["🦊", "🐼", "🦁", "🐘", "🐓", "🦀", "🐷", "🦉"],
        "loves": ["❤️","🧡","💛","💚","💙","💜","🤎","🖤"],
        "faces": ["😀", "🤪", "😬", "😭", "😎", "😍", "🤠", "😇"],
        "people": ["👮🏻‍♂️", "👩‍💻", "👨🏾‍🌾", "🧟‍♀️", "👩🏽‍🎨", "👩🏼‍🍳", "🧕🏼", "💆‍♂️"],
        "transport": ["🚗", "🚓", "🚚", "🏍", "✈️", "🚜", "🚎", "🚲"],
    ]
    
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0{
            let randomStringIndex =  emojiChoices.count.randomNumber
            emoji[card] = emojiChoices.remove(at: randomStringIndex)
        }
        return emoji[card] ?? "?"
    }

}

extension Int {
    var randomNumber: Int {
        if self > 0{
            return Int.random(in: 0..<self)
        } else if self < 0{
            return -Int.random(in: 0..<(-self))
        } else {
            return 0
        }
    }
}
