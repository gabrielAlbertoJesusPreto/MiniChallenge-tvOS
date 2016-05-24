//
//  Question.swift
//  GameShowApp
//
//  Created by Liliane Bezerra Lima on 23/05/16.
//  Copyright © 2016 Gabriel Alberto. All rights reserved.
//

import UIKit
import CloudKit

class Question: NSObject {
    var phrase:         String?
    var answers:        [Answer]?
    var level:          Int?
    var resultsAnswers: [CKReference]?
}
