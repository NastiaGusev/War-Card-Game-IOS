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
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var editButton: UIButton!
    
    var gameManager = GameManager()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerLabel.isHidden = true
    }

    @IBAction func startPressed(_ sender: UIButton) {
        sender.isHidden = true
        editButton.isHidden = true
        updateStartGameUI()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(startTimer), userInfo:nil, repeats: true)
    }
    
    @IBAction func editPressed(_ sender: UIButton) {
        getPlayerNames()
    }
    
    
    func getPlayerNames() {
        let alert = UIAlertController(title: "Enter Player names", message: "", preferredStyle: .alert)
                alert.addTextField { (textField) in
                    textField.placeholder = "Player1"
                }

                alert.addTextField { (textField) in
                    textField.placeholder = "Player2"
                }

                alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
                    if let textField = alert?.textFields?[0], let userText = textField.text {
                        if !userText.isEmpty {
                            self.player1Label.text = userText
                        } else {
                            self.player1Label.text = "Player1"
                        }
                    }

                    if let textField = alert?.textFields?[1], let userText = textField.text {
                        if !userText.isEmpty {
                            self.player2Label.text = userText
                        } else {
                            self.player2Label.text = "Player2"
                        }
                    }
                }))

                self.present(alert, animated: true, completion: nil)
    }
    
    @objc func startTimer() {
        if gameManager.move() {
            updateUI()
        } else {
            timer?.invalidate()
            updateWinnerUI()
        }
    }
    
    func updateWinnerUI() {
        winnerLabel.isHidden = false
        if gameManager.winner == 1 {
            winnerLabel.text = "\(player1Label.text ?? "Player1") is the Winner!!"
        } else if gameManager.winner == 2 {
            winnerLabel.text = "\(player2Label.text ?? "Player2") is the Winner!!"
        } else {
            winnerLabel.text = "Its a draw!!"
        }
        
        //Wait 4s and show start button and update GameManager
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.startButton.isHidden = false
            self.editButton.isHidden = false
            self.progressView.progress = 0.0
            self.gameManager = GameManager()
        }
    }
    
    func updateStartGameUI(){
        player1Score.text = "0"
        player2Score.text = "0"
        winnerLabel.isHidden = true
        leftCard.image = UIImage(named: "cardsDeck")!
        rightCard.image = UIImage(named: "cardsDeck")!
    }
    
    func updateUI() {
        progressView.progress = Float(gameManager.numOfGames) / Float(gameManager.maxGames)
        leftCard.image = UIImage(named: gameManager.leftCard)!
        rightCard.image = UIImage(named: gameManager.rightCard)!
        player1Score.text = String(gameManager.score1)
        player2Score.text = String(gameManager.score2)
    }
    
}
