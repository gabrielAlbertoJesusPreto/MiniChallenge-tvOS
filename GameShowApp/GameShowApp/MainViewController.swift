//
//  ViewController.swift
//  GameShowApp
//
//  Created by Gabriel Alberto de Jesus Preto on 11/05/16.
//  Copyright © 2016 Gabriel Alberto. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var startButton: CustomButton!
    @IBOutlet weak var trophiesButton: CustomButton!
    
    var focusGuide:UIFocusGuide!
    
    let dbManager = ModelManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.updateFocusIfNeeded()
        startButton.setNeedsFocusUpdate()
        
        dbManager.getQuestions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredFocusedView: UIView? {
        return startButton
    }
    
}

