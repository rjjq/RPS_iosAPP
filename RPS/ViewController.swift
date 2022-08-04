//
//  ViewController.swift
//  RPS
//
//  Created by rjjq on 2022/8/3.
//

import UIKit

class ViewController: UIViewController {
    let RSP = ["✌🏼", "✊🏻", "🖐🏻"]
    let directions = ["👆", "👇", "👈", "👉"]

    @IBOutlet weak var winGameLabel: UILabel!
    @IBOutlet var winGameStepper: UIStepper!
    
    var currentWinGame: Int = 1 {
        didSet {
            winGameLabel.text = "\(currentWinGame)"
        }
    }
    
    @IBOutlet weak var myWinLabel: UILabel!
    @IBOutlet weak var computerWinLabel: UILabel!
    @IBOutlet weak var computerShowLabel: UILabel!
    @IBOutlet weak var myShowLabel: UILabel!
    
    var myWin: Int = 0 {
        didSet {
            myWinLabel.text = "\(myWin)"
        }
    }
    var computerWin: Int = 0 {
        didSet {
            computerWinLabel.text = "\(computerWin)"
        }
    }
    
    var myRSP: String?
    var myDirection: String?
    var compRSP: String?
    var compDirection: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        computerShowLabel.text = "\(RSP.first!) \(directions.first!)"
        myShowLabel.text = "\(RSP.first!) \(directions.first!)"
    }

    @IBAction func reset(_ sender: Any) {
        newGame()
    }
    
    @IBAction func play(_ sender: UIButton) {
        if (myWin >= currentWinGame) ||
           (computerWin >= currentWinGame) {
            
            resetAlert()
            return
        }
        
        switch sender.tag {
        case 0,1,2:
            // RPS
            myRSP = RSP[sender.tag]
            compRSP = RSP.shuffled().first!
            myShowLabel.text = myRSP
            computerShowLabel.text = compRSP
            
            if myRSP == compRSP {
                let alert = UIAlertController(title: "Draw", message: "Play Again", preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "Close", style: .default)
                alert.addAction(closeAction)
                present(alert, animated: true, completion: nil)
            }
            break
        case 3,4,5,6:
            // up, down, left, right
            myDirection = directions[sender.tag - 3]
            compDirection = directions.shuffled().first!
            
            myShowLabel.text = "\(myRSP!) \(myDirection!)"
            computerShowLabel.text = "\(compRSP!) \(compDirection!)"
            
            let (title, msg) = checkGame()
            
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .default)
            alert.addAction(closeAction)
            if (myWin >= currentWinGame) ||
                (computerWin >= currentWinGame) {
                let resetAction = UIAlertAction(title: "New Game", style: .default) {_ in
                    self.newGame()
                }
                alert.addAction(resetAction)
            }
            present(alert, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    func resetAlert() {
        let alert = UIAlertController(title: "You Need to Reset", message: "Over WinGame Number : \(currentWinGame) !", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default) {_ in
            self.newGame()
        }
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeWin(_ sender: UIStepper) {
        print(#function, sender.value)
        currentWinGame = Int(winGameStepper.value)
    }
    
    func checkGame() -> (String, String) {
        if myRSP == compRSP {
            return ("Draw", "Play Again")
        } else if (myRSP == "✌🏼" && compRSP == "🖐🏻") ||
                  (myRSP == "✊🏻" && compRSP == "✌🏼") ||
                  (myRSP == "🖐🏻" && compRSP == "✊🏻") {
            
            if myDirection == compDirection {
                myWin += 1
                return ("YOU Win", "Keep going...")
            } else {
                return ("Draw", "Play Again")
            }
            
        } else {
            if myDirection == compDirection {
                computerWin += 1
                return ("You Lose", "Good Luck...")
            } else {
                return ("Draw", "Play Again")
            }
        }
    }
    
    func newGame() {
        myWin = 0
        computerWin = 0
    }
}

