//
//  PlayersViewController.swift
//  GameShowApp
//
//  Created by Liliane Bezerra Lima on 17/05/16.
//  Copyright © 2016 Gabriel Alberto. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SinglePlayer(sender: AnyObject) {
        performSegueWithIdentifier("segueToQuestion", sender: self)
    }

    @IBAction func twoPlayers(sender: AnyObject) {
        performSegueWithIdentifier("segueToQuestion2", sender: self)
    }
    
    @IBAction func threePlayers(sender: AnyObject) {
        performSegueWithIdentifier("segueToQuestion3", sender: self)
    }
    @IBAction func fourPlayers(sender: AnyObject) {
        performSegueWithIdentifier("segueToQuestion4", sender: self)
    }
    
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
 

}
