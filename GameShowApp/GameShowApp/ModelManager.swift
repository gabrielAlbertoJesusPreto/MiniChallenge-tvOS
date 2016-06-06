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
    var questions = [Question]()
    var currentQuestion = 0
    
    func getQuestions(completionHandler: (questions:[Question]) -> ()) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Question", predicate: predicate)
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) in
            if error == nil {
                
                if let questionsResults = results {
                    for question in questionsResults {
                        let questionObject = Question()
                        questionObject.phrase = question.valueForKey("phrase") as? String
                        questionObject.level = question.valueForKey("level") as? Int
                        questionObject.resultsAnswers = question.valueForKey("answer") as? [CKReference]
                        self.questions.append(questionObject)
                }
                    self.questions = self.questions.shuffle()
                    completionHandler(questions: self.questions)
                
            } else {
                    NSNotificationCenter.defaultCenter().postNotificationName("Algum Erro", object: self)
                    
                    print(#function,"Os results estão nil \(error)")
            }
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName("Algum Erro", object: self)
                print(#function,"Erro na listagem de perguntas \(error?.description)")
            }
    }
 }
    
    func fetchAnswer(question:Question, completionHandler: (answers: [Answer],sucess:Bool) -> ()) {
        var answers = [Answer]()
        var employeedRecordIds = [CKRecordID]()
        
        for item in question.resultsAnswers! {
            employeedRecordIds.append(item.recordID)
            publicDatabase.fetchRecordWithID(item.recordID, completionHandler: { (record, error) in
                if error == nil {
                    let answer = Answer()
                    answer.phrase = record!.valueForKey("phrase") as? String
                    answer.isCorrect = record!.valueForKey("isCorrect") as? Int
                    answers.append(answer)
                    
                    if answers.count == 4 {
                        completionHandler(answers: answers,sucess: true)
                    }

                } else {
                    NSNotificationCenter.defaultCenter().postNotificationName("Algum Erro", object: self)
                    print(#function,"Sem conexao fetch")

                }
            })
        }
    }
    
    func getCurrentQuestion(completionHandler: (question:Question, sucess:Bool) ->()) {
            self.getQuestions { (results) in
                self.fetchAnswer(self.questions[self.currentQuestion], completionHandler: { (answers, sucess) in
                    if sucess {
                        self.questions[self.currentQuestion].answers = answers
                        let currentValue = self.currentQuestion
                        self.currentQuestion+=1
                        completionHandler(question: self.questions[currentValue],sucess: sucess)
                    } else {
                        print("Outro erro")
                    }
                })
            }
    }
    
    func getNextQuestion(completionHandler: (question:Question,sucess:Bool) ->()) {
        if currentQuestion >= questions.count {
            print("Erro para proxima questao")
            let questionNil = Question()
            completionHandler(question: questionNil, sucess: false)
        } else {
            self.fetchAnswer(self.questions[self.currentQuestion], completionHandler: { (answers, sucess) in
                if sucess {
                    self.questions[self.currentQuestion].answers = answers
                    let currentValue = self.currentQuestion
                    self.currentQuestion+=1
                    completionHandler(question: self.questions[currentValue],sucess: sucess)
                } else {
                    print("Mais um erro")
                }
            })
        }
        
    }
}


