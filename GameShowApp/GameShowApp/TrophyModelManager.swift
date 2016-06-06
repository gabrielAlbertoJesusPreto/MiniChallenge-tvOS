//
//  TrophyModelManager.swift
//  GameShowApp
//
//  Created by Gabriel Alberto de Jesus Preto on 25/05/16.
//  Copyright © 2016 Gabriel Alberto. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class TrophyModelManager {
    
    static let sharedInstance = TrophyModelManager()
    let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
    
    
    func getTrophyByScore(score: Int, completionHandler: (trophies:[TrophyEntity]) -> ())  {
        
        var trophies = [TrophyEntity]()
        
        let predicate = NSPredicate(format: "score <= %d", score)
        let query = CKQuery(recordType: "Trophy", predicate: predicate)
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) in
            if error == nil {
                if let trophiesResults = results {
                    for trophy in trophiesResults {
                        let trophyObject = TrophyEntity()
                        trophyObject.score = trophy.valueForKey("score") as? Int
                        trophyObject.trophyDescription = trophy.valueForKey("trophyDescription") as? String
                        trophyObject.type = trophy.valueForKey("type") as? Int
                        trophies.append(trophyObject)
                    }
                    completionHandler(trophies: trophies)
                    
                } else {
                    NSNotificationCenter.defaultCenter().postNotificationName("ErrorTrophy", object: self)
                    print(#function,"Erro na listagem de troféus \(error)")
                }
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName("ErrorTrophy", object: self)
                print(#function,"Erro na listagem de troféus \(error)")
            }
        }
    }
    
    func getTrophies(completionHandler: (trophies:[TrophyEntity]) -> ()) {
        
        var trophies = [TrophyEntity]()
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Trophy", predicate: predicate)
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) in
            if error == nil {
                if let trophiesResults = results {
                    for trophy in trophiesResults {
                        let trophyObject = TrophyEntity()
                        trophyObject.score = trophy.valueForKey("score") as? Int
                        trophyObject.trophyDescription = trophy.valueForKey("trophyDescription") as? String
                        trophyObject.type = trophy.valueForKey("type") as? Int
                        trophies.append(trophyObject)
                    }
                    completionHandler(trophies: trophies)
                    
                } else {
                    NSNotificationCenter.defaultCenter().postNotificationName("ErrorTrophy", object: self)
                    print(#function,"Erro na listagem de troféus \(error)")
                }
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName("ErrorTrophy", object: self)
                print(#function,"Erro na listagem de troféus \(error)")
            }
        }
    }
}