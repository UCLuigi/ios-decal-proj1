//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    // Updating the hangman image
    @IBOutlet weak var imageView: UIImageView!
    
    // Updating the phrase blanks
    @IBOutlet weak var phraseLabel: UILabel!
    
    // Updating the incorrect Number Label
    @IBOutlet weak var incorrectGuessesLabel: UILabel!
    
    // Updating the current Guess Label
    @IBOutlet weak var currentGuessLabel: UILabel!
    
    private let hangmanPhrases = HangmanPhrases()
    
    // Current phrase
    private var phrase: String = ""
    
    // Current blank state
    private var blankPhrase: String = ""
    
    // Current guess
    private var currGuess: String = ""
    
    // Letter button just pressed
    private var currGuessButton: UIButton?
    
    // Number of incorrect guesses
    private var incorrectNum: Int = 0
    
    // Array of buttons guessed
    private var buttons: [UIButton] = []
    
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
                
                buttons.append(currGuessButton!)
                currGuessButton?.titleLabel?.textColor = UIColor.green
                currentGuessLabel.text = "Current Guess:  "
                if phrase.replacingOccurrences(of: " ", with: "") == blankPhrase.replacingOccurrences(of: " ", with: "") {
                    //throw win alert
                    let alert = UIAlertController(title: "You Won!", message: "Impressive skills buddy, think you can win again?", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default, handler: {action in self.startOver()}))
                    self.present(alert, animated: true, completion: nil)
                }
                currGuess = ""
            } else {
                currGuessButton?.titleLabel?.textColor = UIColor.red
                buttons.append(currGuessButton!)
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
                currGuess = ""
                currentGuessLabel.text = "Current Guess:  "
                if (incorrectNum == 6) {
                    //throw lose alert
                    let alert = UIAlertController(title: "You Lose", message: "What was that? Try again kid.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default, handler: {action in self.startOver()}))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func startOver() {
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
        for button in buttons {
            button.titleLabel?.textColor = UIColor.white
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
        for button in buttons {
            button.titleLabel?.textColor = UIColor.white
        }
    }
}
