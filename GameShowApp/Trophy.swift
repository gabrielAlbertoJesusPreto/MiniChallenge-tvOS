//
//  Trophy+CoreDataProperties.swift
//  GameShowApp
//
//  Created by Liliane Bezerra Lima on 23/05/16.
//  Copyright © 2016 Gabriel Alberto. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Trophy {

    @NSManaged var score: NSNumber?
    @NSManaged var trophyDescription: String?
    @NSManaged var type: NSNumber?

}
