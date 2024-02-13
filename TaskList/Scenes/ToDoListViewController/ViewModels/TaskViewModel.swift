//
//  TaskViewModel.swift
//  TaskList
//
//  Created by MacBoobPro on 24.01.24.
//

import Foundation

struct TaskViewModel {
    private var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    var id: UUID  {
        task.id ?? UUID()
    }
    
    var name: String {
        task.name ?? ""
    }
    
    var duoOn: Date {
        task.duoOn ?? Date()
    }
    
    var completedOn: Date {
        task.completedOn ?? Date()
    }
    
    var completed: Bool {
        task.completed
    }
}
