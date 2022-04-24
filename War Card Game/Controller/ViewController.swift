//
//  ViewController.swift
//  War Card Game
//
//  Created by Nastia Gusev on 16/04/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftCard: UIImageView!
    @IBOutlet weak var rightCard: UIImageView!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    var gameManager = GameManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerLabel.isHidden = true
    }

    @IBAction func startPressed(_ sender: UIButton) {
        //sender.isHidden = true
        if gameManager.move() {
            leftCard.image = UIImage(named: gameManager.leftCard)!
            rightCard.image = UIImage(named: gameManager.rightCard)!
            player1Score.text = String(gameManager.score1)
            player2Score.text = String(gameManager.score2)
        } else {
            winnerLabel.isHidden = false
            if gameManager.winner == 1 {
                winnerLabel.text = "Player1 is the Winner!!"
            } else if gameManager.winner == 2 {
                winnerLabel.text = "Player2 is the Winner!!"
            } else {
                winnerLabel.text = "Its a draw!!"
            }
            
        }
        
    }
    
}

