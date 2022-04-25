//
//  GameManager.swift
//  War Card Game
//
//  Created by Nastia Gusev on 24/04/2022.
//

import UIKit

struct GameManager {
    var cards = ["2-clubs","2-diamonds", "2-spades","2-hearts","3-clubs","3-diamonds", "3-spades","3-hearts","4-clubs","4-diamonds", "4-spades","4-hearts","5-clubs","5-diamonds", "5-spades","5-hearts","6-clubs","6-diamonds", "6-spades","6-hearts","7-clubs","7-diamonds", "7-spades","7-hearts","8-clubs","8-diamonds", "8-spades","8-hearts","9-clubs","9-diamonds", "9-spades","9-hearts","10-clubs","10-diamonds", "10-spades","10-hearts","11-clubs","11-diamonds", "11-spades","11-hearts","12-clubs","12-diamonds", "12-spades","12-hearts","13-clubs","13-diamonds", "13-spades","13-hearts","14-clubs","14-diamonds", "14-spades","14-hearts","15-jokers","15-jokersb"]
    
    var leftCard: String = ""
    var rightCard: String = ""
    var score1: Int = 0
    var score2: Int = 0
    var gameOver: Bool = false
    
    var numOfGames: Int = 0
    var maxGames: Int = 28
    
    
    var winner: Int {
        if score1 > score2 {
            return 1
        } else if score1 < score2 {
            return 2
        } else {
            return 0
        }
    }
    
    mutating func checkWinningCard() {
        let card1Value = Int.parse(from: leftCard)!
        let card2Value = Int.parse(from: rightCard)!
        
        if card1Value > card2Value {
            score1 += 1
        } else if card1Value < card2Value {
            score2 += 1
        }
    }
    
    mutating func getNextCards(){
        if !cards.isEmpty {
            leftCard = cards.randomElement()!
            cards.removeAll { $0 == leftCard }
            rightCard = cards.randomElement()!
            cards.removeAll { $0 == rightCard}
        } else {
            gameOver = true
        }
    }
    
    mutating func move() -> Bool{
        if !gameOver {
            getNextCards()
            checkWinningCard()
            numOfGames += 1
            return true
        } else {
            return false
        }
    }
    
}

extension Int {
    static func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
