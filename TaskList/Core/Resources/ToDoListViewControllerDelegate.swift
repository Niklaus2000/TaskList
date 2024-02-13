//
//  ToDoListViewControllerDelegate.swift
//  TaskList
//
//  Created by MacBoobPro on 07.02.24.
//

import UIKit

extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = viewModel.task(by: indexPath.row)
        
        let completAction = UIContextualAction(style: .normal, title: task.completed ? "Not Completed" : "Completed") {[weak self] (action, view, complentionHandler) in
           
            self?.completedTask(at: indexPath)
            complentionHandler(true)
        }
        completAction.backgroundColor = task.completed ? .systemRed: .systemGreen
        
        let configuraation = UISwipeActionsConfiguration(actions: [completAction])
        configuraation.performsFirstActionWithFullSwipe = true
        return configuraation
    }
    
    func completedTask(at indexPath: IndexPath) {
        let task = viewModel.task(by: indexPath.row)
        viewModel.toggleComleted(task: task)
        
        if task.completed {
            celebrationAnimationView.isHidden = true
            celebrationAnimationView.play { finished in
                self.celebrationAnimationView.isHidden = finished
            }
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        indexPath.section != 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        let task = viewModel.task(by: indexPath.row)
        viewModel.deleteItem(task: task)
        tableView.reloadData()
    }
}
