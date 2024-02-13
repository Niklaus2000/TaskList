//
//  TaskListViewModel.swift
//  TaskList
//
//  Created by MacBoobPro on 24.01.24.
//

import Foundation

class TaskListViewModel {
    var tasks = [TaskViewModel]()
    
    init() {
        getAll()
    }
    
    func getAll() {
        tasks  = CoreDataManager.shared.getAll().map(TaskViewModel.init)
    }
    
    var numberOfTasks: Int {
        tasks.count
    }
    
    func numberOfRows(by section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return numberOfTasks
    }
    
    func getTaskByType() -> (commplete: Int, inComplete: Int) {
        let completeCount = tasks.lazy.filter( { $0.completed } ).count
        let inCompleteCount = tasks.lazy.filter( { !$0.completed } ).count
        
        return (completeCount, inCompleteCount)
    }
    
    func task(by index: Int) -> TaskViewModel {
        tasks[index]
    }
    
    func toggleComleted(task: TaskViewModel) {
        CoreDataManager.shared.toggleCompleted(id: task.id)
        getAll()
    }
    
    func deleteItem(task: TaskViewModel) {
        CoreDataManager.shared.delete(id: task.id)
        getAll()
    }
}
