//
//  HangmanPhrases.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import Foundation

class HangmanPhrases {
    
    var phrases : NSArray!
    
    // Initialize HangmanPhrase with an array of all possible phrases of the Hangman game
    init() {
        let path = Bundle.main.path(forResource: "phrases", ofType: "plist")
        phrases = NSArray.init(contentsOfFile: path!)
    }
    
    // Get random phrase from all available phrases
    func getRandomPhrase() -> String {
        let index = Int(arc4random_uniform(UInt32(phrases.count)))
        return phrases.object(at: index) as! String
    }
    
    // Convert phrase to a blank phrase with underscores
    func convertToBlanks(str: String) -> String {
        var blankPhrase: String = ""
        for character in str.characters {
            if character == " " {
                blankPhrase += "  "
            } else {
                blankPhrase += "_ "
            }
        }
        return blankPhrase
    }
    
    // Replaces underscores with letters in appropriate position
    func replaceBlankWithLetter(phrase: String, blanks: inout String, letter: String) -> String {
        var iter: Int = 0
        for character in phrase.characters {
            if (character == Character(letter)) {
                let start = blanks.index(blanks.startIndex, offsetBy: iter)
                let end = blanks.index(blanks.startIndex, offsetBy: iter + 1)
                blanks = blanks.replacingCharacters(in: start..<end, with: letter)
            }
            iter += 2
        }
        return blanks
    }
    
}
