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
    
    var NOUGHT = "O"
    var CROSS = "X"
    
    //Runs the constructor and creates a list of all buttons
    var board = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initboard()
    }
    
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
        
        if (fullBoard())
        {
            resultAlert(title: "Draw")
        
        }
    }
    
    
    func resultAlert(title: String)
    {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
        
        
    }
    
    func resetBoard()
    {
        for button in board{
            
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
            
        }
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
    
    
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil{
            return false
            }
        }
        return true
    }
    
    
    func addToBoardGrid(_ sender: UIButton) {
        if sender.title(for: .normal) == nil {
            if (currentTurn == Turn.Nought) {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabal.text = CROSS
            }
            else if (currentTurn == Turn.Cross) {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabal.text = NOUGHT
            
            }
            
            //Remove a animation X or O that already been placed
            sender.isEnabled = false
            
        }
    }
   

}

