//
//  ModelManager.swift
//  GameShowApp
//
//  Created by Liliane Bezerra Lima on 23/05/16.
//  Copyright © 2016 Gabriel Alberto. All rights reserved.
//

import UIKit
import CloudKit

class ModelManager {
    static let sharedInstance = ModelManager()
    let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
    
    func getQuestions() {
        
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Question", predicate: predicate)
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) in
            if error == nil {
                if let questions = results {
                    for question in questions {
                        let questionObject = Question()
                        questionObject.phrase = question.valueForKey("phrase") as? String
                        questionObject.level = question.valueForKey("level") as? Int
                        let fetchAnswers = question.valueForKey("answer")
                        print(fetchAnswers)
                    }
                }
                
            } else {
                print(#function,"Erro na listagem de perguntas \(error)")
            }
        }
    }
    
    
    
}
