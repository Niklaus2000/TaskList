//
//  CoreDataManager.swift
//  TaskList
//
//  Created by MacBoobPro on 26.01.24.
//

import Foundation
import CoreData

class  CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    var context: NSManagedObjectContext  {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Error saving staged changes \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getAll() -> [Task] {
        var tasks = [Task]()
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortByDueDate = NSSortDescriptor(key: "duoOn", ascending: true)
        fetchRequest.sortDescriptors = [sortByDueDate]
        do {
            tasks = try context.fetch(fetchRequest)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return tasks
        
    }
    
    func addNewTask(name: String, dueOn: Date) {
        let task = Task(context: context)
        task.name = name
        task.duoOn = dueOn
        
        task.id = UUID()
        task.completed = false
        task.completedOn = dueOn.advanced(by: 1000000)
        
        saveContext()
    }
    
    func toggleCompleted(id: UUID) {
        let fetchRequest: NSFetchRequest = Task.fetchRequest()
        let prediccate = NSPredicate(format: "id=%@", id.uuidString)
        
        do {
            if let fetchTask = try
                context.fetch(fetchRequest).first(where: { $0.id == id
                }) {
                fetchTask.completed = !fetchTask.completed
                if fetchTask.completed {
                    fetchTask.completedOn = Date()
                }
                
            }
            
            saveContext()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func delete(id: UUID) {
        let fetchrequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        fetchrequest.predicate = NSPredicate(format: "id=%@", id.uuidString)
        
        do {
            let fetchTasks = try context.fetch(fetchrequest)
            
            for task in fetchTasks {
                context.delete(task)
            }
            
            saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
}
