//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var phraseLabel: UILabel!
    
    @IBOutlet weak var incorrectGuessesLabel: UILabel!

    @IBOutlet weak var currentGuessLabel: UILabel!
    
    private let hangmanPhrases = HangmanPhrases()
    
    private var phrase: String = ""
    
    private var blankPhrase: String = ""
    
    private var currGuess: String = ""
    
    private var currGuessButton: UIButton?
    
    private var incorrectNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        
        phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        blankPhrase = hangmanPhrases.convertToBlanks(str: phrase)
        print(blankPhrase)
        phraseLabel.text = blankPhrase
        incorrectGuessesLabel.text = "Incorrect Guesses:  0"
        currentGuessLabel.text = "Current Guess:  "
        imageView.image = #imageLiteral(resourceName: "hangman1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        let letter: String = sender.currentTitle!
        currGuess = letter
        currentGuessLabel.text = "Current Guess:  " + letter
        currGuessButton = sender
    }

    @IBAction func guessButtonPressed(_ sender: UIButton) {
        if currGuess != "" {
            if phrase.contains(currGuess) {
                blankPhrase = hangmanPhrases.replaceBlankWithLetter(phrase: phrase, blanks: &blankPhrase, letter: currGuess)
                phraseLabel.text = blankPhrase
                print(blankPhrase)
                
                currGuessButton?.titleLabel?.textColor = UIColor.green
                if phrase.replacingOccurrences(of: " ", with: "") == blankPhrase.replacingOccurrences(of: " ", with: "") {
                    //throw win alert
                    
                }
                currGuess = ""
            } else {
                currGuessButton?.titleLabel?.textColor = UIColor.red
                incorrectNum += 1
                switch incorrectNum {
                    case 1:
                        imageView.image = #imageLiteral(resourceName: "hangman2")
                    case 2:
                        imageView.image = #imageLiteral(resourceName: "hangman3")
                    case 3:
                        imageView.image = #imageLiteral(resourceName: "hangman4")
                    case 4:
                        imageView.image = #imageLiteral(resourceName: "hangman5")
                    case 5:
                        imageView.image = #imageLiteral(resourceName: "hangman6")
                    case 6:
                        imageView.image = #imageLiteral(resourceName: "hangman7")
                default:
                    imageView.image = #imageLiteral(resourceName: "hangman1")
                }
                incorrectGuessesLabel.text = "Incorrect Guesses: " + String(incorrectNum)
                if (incorrectNum == 6) {
                    //throw lose alert
                }
            }
        }
    }
    
    @IBAction func startOverButtonPressed(_ sender: UIButton) {
        phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        blankPhrase = hangmanPhrases.convertToBlanks(str: phrase)
        print(blankPhrase)
        phraseLabel.text = blankPhrase
        incorrectGuessesLabel.text = "Incorrect Guesses:  0"
        incorrectNum = 0
        currGuess = ""
        currentGuessLabel.text = "Current Guess:  "
        imageView.image = #imageLiteral(resourceName: "hangman1")
    }
}
