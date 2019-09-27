//
//  TaskController.swift
//  Task
//
//  Created by Michael Di Cesare on 9/25/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import Foundation
import CoreData


class TaskController {
    //singleton
    static let shared = TaskController()
    // source of truth
//     var tasks: [Task] = []
    // MARK: - Becky: Excutive Assistant
    var fetchedRequestController: NSFetchedResultsController<Task>
    init() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            let isComplete = NSSortDescriptor(key: "isComplete", ascending: false)
            let due = NSSortDescriptor(key: "due", ascending: false)
        
        fetchRequest.sortDescriptors = [isComplete, due]
        
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        fetchedRequestController = resultsController
        do {
            try fetchedRequestController.performFetch()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    
    
    
    // MARK: - CRUD
    func add(taskWithName name: String, notes: String, due: Date) {
        let _ = Task(name: name, due: due, notes: notes)
        saveToPersistentStore()
     //   tasks = fetchTask()
    }
    
    func update(task: Task, name: String, notes: String? , due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due as Date?
        saveToPersistentStore()
     //   tasks = fetchTask()
    }
    func remove(task: Task) {
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
      //  tasks = fetchTask()
    }
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
//    func fetchTask() -> [Task] {
//        let request: NSFetchRequest<Task> = Task.fetchRequest()
//        return (try? CoreDataStack.context.fetch(request)) ?? []
//    }
    
    
}// end of class
