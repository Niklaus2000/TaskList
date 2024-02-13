//
//  ToDoListViewControllerDataSources.swift
//  TaskList
//
//  Created by MacBoobPro on 07.02.24.
//

import Foundation
import UIKit


extension ToDoListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(by: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryTableViewCell  else {
                return UITableViewCell()
            }
            let taskSummary = viewModel.getTaskByType()
            cell.configure(complited: taskSummary.commplete.description, inComplited: taskSummary.inComplete.description)
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        
        let task = viewModel.task(by: indexPath.row)
        cell.configure(task: task)
        return cell
    }
}
