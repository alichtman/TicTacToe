//
//  SecondViewController.swift
//  TicTacToe
//
//  Created by Aaron Lichtman on 7/21/16.
//  Copyright © 2016 Aaron Lichtman. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController { 

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gridLabel0: GridLabel!
    @IBOutlet weak var gridLabel1: GridLabel!
    @IBOutlet weak var gridLabel2: GridLabel!
    @IBOutlet weak var gridLabel3: GridLabel!
    @IBOutlet weak var gridLabel4: GridLabel!
    @IBOutlet weak var gridLabel5: GridLabel!
    @IBOutlet weak var gridLabel6: GridLabel!
    @IBOutlet weak var gridLabel7: GridLabel!
    @IBOutlet weak var gridLabel8: GridLabel!
    
    //X will go first
    var xTurn = true
    
    var gameOverFlag = false
    
    var moveCounter = 0
    
    //Initializing an array of type GridLabel
    var labelsArray = [GridLabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelsArray = [gridLabel0, gridLabel1, gridLabel2, gridLabel3, gridLabel4, gridLabel5, gridLabel6, gridLabel7, gridLabel8]
        
        //Initialize all labels to ""
        for item in labelsArray {
            
            item.text = ""
        }
        
    }
    
    
    func checkWinner() {
        
        //Win Logic
        
        var lastPlayer = ""
        
        //Reversed players already. This works.
        if xTurn != true {

            lastPlayer = "X"
        }
        else {
            lastPlayer = "O"
            
        }
        
        let solutionsArray : [(Int, Int, Int)] = [(0,3,6),(1,4,7),(2,5,8),(0,1,2),(3,4,5),(6,7,8),(0,4,8),(6,4,2)]
        
        moveCounter += 1
        
        for solution in solutionsArray {

            if labelsArray[solution.0].text == lastPlayer && labelsArray[solution.1].text == lastPlayer && labelsArray[solution.2].text == lastPlayer {
                
                //Call winMessage
                winMessage(lastPlayer)
                gameOverFlag = true
    
            }

            if moveCounter == 9 && gameOverFlag == false {
                tieMessage()
            }
            
        }
            
    
    }
    
    @IBAction func onTappedGridLabel(sender: UITapGestureRecognizer) {
        
        if gameOverFlag == false {
        
        //Run through each label in labelsArray. 
        var counter = 0
        for label in labelsArray {
            
            //Figure out whether to place an X or an O.
            if CGRectContainsPoint(label.frame, sender.locationInView(backgroundView)) {
                
                //Checks if space is occupied
                if label.text == "" {
                    
                    //Turn logic
                    if xTurn == true {
                        label.text = "X"
                        counter += 1
                    }
                    else if xTurn != true {
                        label.text = "O"
                    }
                    xTurn = !xTurn
                }
            }
            }
        }
        
        //Win detection
        //Return a value (winner)
        
        checkWinner()
        
    }
    
    @IBAction func onButtonPressReset(sender: AnyObject) {
        viewDidLoad()
        xTurn = true
    }
    
    //This line is to make the compiler happy.
    var winner = ""

    
    func winMessage(value: String) {

        let message = "\(value) wins."
        let alert = UIAlertController(title: "Win", message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok.", style: .Destructive, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    //Cat's game message
    
    func tieMessage() {
        
        let message = "Nobody wins."
        let alert = UIAlertController(title: "Tie", message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok.", style: .Destructive, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

}