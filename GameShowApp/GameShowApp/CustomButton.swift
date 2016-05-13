//
//  CustomButton.swift
//  GameShowApp
//
//  Created by Liliane Bezerra Lima on 13/05/16.
//  Copyright © 2016 Gabriel Alberto. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override func canBecomeFocused() -> Bool {
        return true
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView == self {
            coordinator.addCoordinatedAnimations({
                
                self.transform = CGAffineTransformMakeScale(1.15, 1.15)
                self.layer.cornerRadius = 10
            }, completion: nil)
            
        } else if context.previouslyFocusedView == self {
            coordinator.addCoordinatedAnimations({
                self.transform = CGAffineTransformMakeScale(1, 1)
                self.layer.cornerRadius = 0
                }, completion: nil)
        }
    }
    
    

}
