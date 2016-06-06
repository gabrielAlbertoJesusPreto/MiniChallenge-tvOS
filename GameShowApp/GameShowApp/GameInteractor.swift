//
//  GameInteractor.swift
//  GameShowApp
//
//  Created by Liliane Bezerra Lima on 23/05/16.
//  Copyright (c) 2016 Gabriel Alberto. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol GameInteractorInput {
    func doFirstQuestion()
    func selectAnswer(request: GameScoreRequest)
    func nextQuestion()
    func doVerificationNewTrophy(request: GameRequest.VerifyNewTRophy)
}

protocol GameInteractorOutput {
    func presentSomething(response: GameResponse)
    func presentNewTrophy(response: GameResponse.NewTrophy)
    func presentNoNewTrophy(response: GameResponse.NoNewTrophy)
    func presentScore(response: GameScoreResponse)
}

class GameInteractor: GameInteractorInput {
    var output: GameInteractorOutput!
    var worker: GameWorker!
    var workerTrophyManager: TrophyModelManager!
    var workerScore:GameScoreWorker!
    
  
  // MARK: Business logic
  
  func doFirstQuestion() {
    worker = GameWorker()
    worker.getAnswerWork { (question, sucess) in
        var response = GameResponse()
        response.question = question
        response.sucess = sucess
        self.output.presentSomething(response)
    }
  }
    
    func selectAnswer(request: GameScoreRequest) {
        workerScore = GameScoreWorker()
        var response = GameScoreResponse()
        if request.isCorrect == true {
            let score = workerScore.calculateScore(request.level!)
            response.score = score
            response.isCorrect = request.isCorrect
            output.presentScore(response)
        }
    }
    
    func nextQuestion() {
        worker = GameWorker()
        worker.nextQuestion { (question, sucess) in
            var response = GameResponse()
            response.question = question
            response.sucess = sucess
            self.output.presentSomething(response)
        }
    }
    func doVerificationNewTrophy(request: GameRequest.VerifyNewTRophy) {
        
        workerTrophyManager = TrophyModelManager()
        workerTrophyManager.getTrophyByScore(request.score!) { (trophies) in
            if trophies.count > 0 {
                    
                var trophiesDidNotExist = [TrophyEntity]()
                    
                for item in trophies {
                    if !(TrophyManager.sharedInstance.trophyExists(item.score!)) {
                        trophiesDidNotExist.append(item)
                        TrophyManager.sharedInstance.newTrophy(item.score!, trophyDescription: item.trophyDescription!, type: item.type!)
                        TrophyManager.sharedInstance.save()
                    }
                }
                    
                if trophiesDidNotExist.count > 0 {
                    var response = GameResponse.NewTrophy()
                    response.trophies = trophiesDidNotExist
                    self.output.presentNewTrophy(response)
                    return
                }
                    
            }
            
            let response = GameResponse.NoNewTrophy()
            self.output.presentNoNewTrophy(response)
        }
    }
}
