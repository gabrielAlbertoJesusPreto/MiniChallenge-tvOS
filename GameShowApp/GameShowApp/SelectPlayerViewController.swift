//
//  SelectPlayerViewController.swift
//  GameShowApp
//
//  Created by Liliane Bezerra Lima on 23/05/16.
//  Copyright © 2016 Gabriel Alberto. All rights reserved.
//

import UIKit

class SelectPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectPlayers(sender: CustomButton) {
        self.performSegueWithIdentifier("inputNames", sender: sender)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? ChooseUsernameViewController {
            vc.numberOfPlayers = sender?.tag
        }
    }

}
