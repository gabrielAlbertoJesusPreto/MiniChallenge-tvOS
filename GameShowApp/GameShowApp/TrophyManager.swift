//
//  Tr.swift
//  GameShowApp
//
//  Created by Gabriel Alberto de Jesus Preto on 24/05/16.
//  Copyright © 2016 Gabriel Alberto. All rights reserved.
//

import UIKit
import CoreData

public class TrophyManager {
    static let sharedInstance: TrophyManager = TrophyManager()
    static let entityName: String = "Trophy"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c
    }()
    
    private init(){}
    
    func save() {
        
        var error: NSError?
        
        do {
            try managedContext.save()
        } catch let e as NSError {
            error = e
        }
        
        if let e = error {
            print("Could not save. Error: \(e.localizedDescription)")
        }
        
    }
    
    func newTrophy(score: Int, trophyDescription: String, type: Int) -> Trophy {
        
        
        let result = TrophyManager.sharedInstance.getTrophyByScore(score)
        
        if result.count > 0 {
            TrophyManager.sharedInstance.deleteTrophy(score)
        }
        
        let trophy = NSEntityDescription.insertNewObjectForEntityForName(TrophyManager.entityName, inManagedObjectContext: managedContext) as! Trophy
        
        trophy.score = score
        trophy.trophyDescription = trophyDescription
        trophy.type = type
        
        return trophy
    }
    
    
    func getTrophies() -> [Trophy] {
        
        var trophies = [Trophy]()
        
        let fetchRequest = NSFetchRequest(entityName: TrophyManager.entityName)
        
        let error: NSError?
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults as? [Trophy] {
                trophies = results
            }
            
        } catch let e as NSError {
            error = e
            if let e = error {
                print("Could not fetch. Error: \(e.localizedDescription)")
            }
        }
        
        return trophies
        
    }
    
    func getTrophyByScore(score: Int) -> [Trophy] {
        
        var trophies = [Trophy]()
        
        let fetchRequest = NSFetchRequest(entityName: TrophyManager.entityName)
        
        let error: NSError?
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults as? [Trophy] {
                
                for item in results {
                    if item.score == score {
                        trophies.append(item)
                    }
                }
                
            }
            
        } catch let e as NSError {
            error = e
            if let e = error {
                print("Could not fetch. Error: \(e.localizedDescription)")
            }
        }
        
        return trophies
        
    }
    
    
    func deleteTrophy(score: Int) {
        
        let result = TrophyManager.sharedInstance.getTrophyByScore(score)
        
        for item in result {
            
            if item.score == score {
                managedContext.deleteObject(item)
            }
            
        }
        
    }
    
}
