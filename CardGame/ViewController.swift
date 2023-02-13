//
//  ViewController.swift
//  CardGame
//
//  Created by Lisette Antigua on 2/9/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var card:UIImageView!
    @IBOutlet var score:UILabel!
    
    var game:Game = Game()
    
    // Try Again Screen
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var gameover: UILabel!
    @IBOutlet weak var tryagain: UIButton!
    @IBOutlet weak var finalscore: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newRound(true)
        
    }
    

    @IBAction func low(_ sender: Any) {
        game.rule = .low
        
        switch game.check(){
        case true:
            game.score += 1
            newRound(false)
        case false:
            gameOver(state: false)
        }
    }
    
    @IBAction func high(_ sender: Any) {
        game.rule = .high
        switch game.check(){
        case true:
            game.score += 1
            newRound(false)
        case false:
            gameOver(state: false)
        }
        
        
    }
    
    func newRound(_ new:Bool){
        if new == false{
            game.newValues(prev: game.nextNumber, next: game.rando(), rule: .low)
        }
        else{
            game.newValues(prev: game.rando(), next: game.rando(), rule: .low)
            game.score = 0
        }
        card.image = UIImage(named: String(game.previousNumber))!
        score.text = String(game.score)
    }
    
    
    func gameOver(state:Bool){
        background.isHidden = state
        tryagain.isHidden = state
        gameover.isHidden = state
        finalscore.isHidden = state
        finalscore.text = String(game.score)
    }
    
    @IBAction func restart(_ sender: Any) {
        gameOver(state: true)
        newRound(true)
    }
}

enum Rule{
    case high
    case low
}

struct Game{
    var rule:Rule
    var previousNumber:Int
    var nextNumber:Int
    var score = 0
    
    init(){
        rule = .low
        previousNumber = 0
        nextNumber = 0
    }
    
    func rando()->Int{
        return Int.random(in: 2...14)
    }
    
    mutating func newValues(prev:Int, next:Int, rule:Rule){
        self.rule = rule
        previousNumber = prev
        nextNumber = next
    }
    
    func check()->Bool{
        switch rule{
        case .high:
            if previousNumber > nextNumber{
                return false
            }
        case .low:
            if previousNumber < nextNumber{
                return false
            }
        }
        return true
    }

}

