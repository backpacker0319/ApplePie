//
//  ViewController.swift
//  Apple Pie
//
//  Created by student10 on 2/14/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TreeImageView: UIImageView!
    @IBOutlet weak var CorrectLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet var LetterButton: [UIButton]!
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program" ]
    var incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newRound()
    }
    func enableLetterButtons (_ enable: Bool) {
        for button in LetterButton {
            button.isEnabled = enable
        }
    }
        
        func newRound() {
            if !listOfWords.isEmpty{
                
        let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
            }else {
                enableLetterButtons(false)
            }
    }
        func updateUI(){
            CorrectLabel.text = currentGame.formattedWord
            ScoreLabel.text = "Wins \(totalWins), Losses: \(totalLosses)"
            TreeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        }
        
        func updateGameState(){
            if currentGame.incorrectMovesRemaining == 0 {
                totalLosses += 1
            } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            } else {
                updateUI()
            }
            
            
            
}
}
