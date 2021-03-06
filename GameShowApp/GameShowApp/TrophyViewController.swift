//
//  TrophyViewController.swift
//  GameShowApp
//
//  Created by Gabriel Alberto de Jesus Preto on 28/05/16.
//  Copyright (c) 2016 Gabriel Alberto. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit


class TrophyViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var numberOfItems: Int = 0
    var userTrophies = [TrophyEntity]()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TrophyViewController.showError), name: "ErrorTrophy", object: nil)
            
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        self.collectionView.hidden = true
        
        self.userTrophies = self.getUserTrophies()
        self.numberOfTrophiesOnCloud()
        
    }
    
    func numberOfTrophiesOnCloud() {
        TrophyModelManager().getTrophies { (trophies) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.activityIndicator.hidden = true
                self.activityIndicator.stopAnimating()
                self.collectionView.hidden = false
                
                self.numberOfItems = trophies.count
                self.collectionView.reloadData()
            })
        }
    }
    
    func getUserTrophies() -> [TrophyEntity] {
        
        let trophies = TrophyManager.sharedInstance.getTrophies()
        var trophiesEntity = [TrophyEntity]()
        
        for item in trophies {
            let trophyObject = TrophyEntity()
            
            if let score = item.score {
                trophyObject.score = Int(score)
            }
            
            if let trophyDescription = item.trophyDescription {
                trophyObject.trophyDescription = trophyDescription
            }
            
            if let type = item.type {
                trophyObject.type = Int(type)
            }
    
            trophiesEntity.append(trophyObject)
            
        }
        
        trophiesEntity.sortInPlace({ $0.score < $1.score })
        
        return trophiesEntity
    }
    
}


// MARK: UICollectionView Delegate and DataSource
extension TrophyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfItems
    
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("TrophyItem", forIndexPath: indexPath) as! TrophyCollectionViewCell
        
        if indexPath.row == 0 {
            cell.updateFocusIfNeeded()
            cell.setNeedsFocusUpdate()
        }
        
        if indexPath.row <= userTrophies.count-1 {
            cell.trophyLabel.text = "\(userTrophies[indexPath.row].score!) pontos"
            
            if userTrophies[indexPath.row].type == 1 {
                
                cell.trophyImageView.image = UIImage(named: "gold")
                
            } else if userTrophies[indexPath.row].type == 2 {
                
                cell.trophyImageView.image = UIImage(named: "silver")
                
            } else if userTrophies[indexPath.row].type == 3 {
                
                cell.trophyImageView.image = UIImage(named: "bronze")
                
            }
        }
        
        else {
            cell.trophyLabel.text = "???"
            cell.trophyImageView.image = UIImage(named: "???")
        }
        
        return cell
    
    }

    func showError() {
         let alert = UIAlertController(title: "Erro de conexão", message: "Desculpe, por favor verifique a conexão e se está conectado ao iCloud e tente novamente", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert) in
            self.navigationController?.popToRootViewControllerAnimated(true)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
