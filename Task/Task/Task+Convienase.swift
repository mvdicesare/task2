//
//  Task+Convienase.swift
//  Task
//
//  Created by Michael Di Cesare on 9/25/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    convenience init(name: String, due: Date = Date(), notes: String, isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.due = due
        self.isComplete = isComplete
        self.notes = notes 
    }
    
}
