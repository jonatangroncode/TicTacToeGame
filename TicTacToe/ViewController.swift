//
//  ViewController.swift
//  TicTacToe
//
//  Created by ITHS on 2022-12-14.
//  Copyright © 2022 ITHS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // to know whos turn it is, it defines turn witch can be eiter nought or cross depending whos turn it is
    enum Turn {
        case Nought
        case Cross
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var turnLabal: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    //initializes with values from the enum and are set to cross so we know whos starting
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    //constant strings 
    var NOUGHT = "O"
    var CROSS = "X"
    
    //Runs the constructor and creates a list of all buttons
    var board = [UIButton]()
    
    // assign 0 as start value
    var noughtsScore = 0
    var crossessScore = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //call function to fill the list
        initboard()
    }
    
    //initializes the the board and popularize the list with the buttons in the grid
    func initboard()
    {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func boardTapAction(_ sender: UIButton) {
        
        addToBoardGrid(sender)
        
        //if there is three O in a row the score change and result alert gets a titel
        if checkForVictory(CROSS){
            crossessScore += 1
            resultAlert(title: "Crosses Win!")
        }
        
        //if there is three O in a row the score change and result alert gets a titel
        if checkForVictory(NOUGHT){
            noughtsScore += 1
            resultAlert(title: "Noughts Win!")
        }
        
        //if all button has been pressed its a draw
        if (fullBoard())
        {
            resultAlert(title: "Draw")
        
        }
    }
    
    //Checking every three in a row that X or O can have
    func checkForVictory(_ s :String) -> Bool {
        
        // Horizontal victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) {
            
            return true
        }
        
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) {
            
            return true
        }
        
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) {
            
            return true
        }
        
        // Vertical victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) {
            
            return true
        }
        
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) {
            
            return true
        }
        
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) {
            
            return true
        }
        
        // Diagonol victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) {
            
            return true
        }
        
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s) {
            
            return true
        }
        
      
        
        return false
    }
    
    //controll if button title is the same as symbol then return true
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        
        return button.title(for: .normal) == symbol
    }
    
    
    //Shows a message in the end of the game who won, the current score and a button to restart a new game
    func resultAlert(title: String)
    {
        let message = "\nNoughts " + String(noughtsScore) + "\n\nCrosses " + String(crossessScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet) //Showing title and message
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in //ResetButton
            self.resetBoard() //Clear the board
        }))
        self.present(ac, animated: true)
        
        
    }
    
    //Resetsset all button titels to nill and enabels them
    func resetBoard()
    {
        for button in board{
            
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
            
        }
        
        //change person that starts next game
        if (firstTurn == Turn.Nought)
        {
            firstTurn = Turn.Cross
            turnLabal.text = CROSS
        }
        
        else if (firstTurn == Turn.Cross)
        {
            firstTurn = Turn.Nought
            turnLabal.text = NOUGHT
        }
        currentTurn = firstTurn
    
    }
    
    
    //Checks for emty space on the board, button without titel
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil{
            return false
            }
        }
        return true
    }
    
    //If the butten pressed dont have a title change title and turnlabel by using a ternary operator
    func addToBoardGrid(_ sender: UIButton) {
        if sender.title(for: .normal) == nil {
            let newTitle = (currentTurn == Turn.Nought) ? NOUGHT : CROSS
            sender.setTitle(newTitle, for: .normal)
            currentTurn = (currentTurn == Turn.Nought) ? Turn.Cross : Turn.Nought
            turnLabal.text = (currentTurn == Turn.Nought) ? NOUGHT : CROSS
            
            // Remove the animation if the button already has been pressed
            sender.isEnabled = false
        }
    }
   

}

