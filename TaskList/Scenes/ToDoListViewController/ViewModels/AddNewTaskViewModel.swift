//
//  AddNewTaskViewModel.swift
//  TaskList
//
//  Created by MacBoobPro on 26.01.24.
//

import Foundation

class AddNewTaskViewModel {
    func addTask(name: String, duoOn: Date) {
        CoreDataManager.shared.addNewTask(name: name, dueOn: duoOn)
    }
}
