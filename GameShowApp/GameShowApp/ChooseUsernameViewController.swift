//
//  ChooseUsernameViewController.swift
//  GameShowApp
//
//  Created by Kaique Damato on 5/24/16.
//  Copyright © 2016 Gabriel Alberto. All rights reserved.
//

import UIKit

class ChooseUsernameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var playerLabel: UILabel!
    
    var numberOfPlayers: Int?
    var players = [(String, Int)]()
    var currentUsername = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func chooseName(sender: UIButton) {
        guard numberOfPlayers != nil else {
            return
        }
        
        if nameTextField != "" && numberOfPlayers! != currentUsername {
            players.append((nameTextField.text!, 0))
            nameTextField.text = ""
            getNextUsername()
        } else {
            self.performSegueWithIdentifier("startGame", sender: self)
        }
    }
    
    func getNextUsername() {
        currentUsername += 1
        playerLabel.text = "Player \(currentUsername)"
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = segue.destinationViewController as? GameViewController {
            viewController.players = players
        }
    }

}
