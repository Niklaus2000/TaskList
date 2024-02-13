//
//  AddNewTaskViewController.swift
//  TaskList
//
//  Created by MacBoobPro on 30.01.24.
//

import UIKit

class AddNewTaskViewController: UIViewController {
    
    let viewModel = AddNewTaskViewModel()
    
    private let taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Task Name"
        return label
    }()
    
    private let taskNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Enter Task Name"
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    private let dueOnLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Duo On"
        return label
    }()
    
    private let dueOnDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    private func setUpView() {
        view.backgroundColor = UIColor.systemBackground
        title = "Add New Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        
        [taskNameLabel,
         taskNameTextField,
         dueOnLabel,
         dueOnDatePicker].forEach { subViewtoAdd in
            view.addSubview(subViewtoAdd)
        }
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16),
            taskNameLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16),
            taskNameTextField.topAnchor.constraint(
                equalTo: taskNameLabel.bottomAnchor,
                constant: 8),
            taskNameTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            taskNameTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            dueOnLabel.topAnchor.constraint(
                equalTo: taskNameTextField.bottomAnchor,
                constant: 8),
            dueOnLabel.leadingAnchor.constraint(
                equalTo: taskNameTextField.leadingAnchor,
                constant: -16),
            dueOnDatePicker.topAnchor.constraint(
                equalTo: taskNameTextField.bottomAnchor,
                constant: 8),
            dueOnDatePicker.trailingAnchor.constraint(
                equalTo: taskNameTextField.trailingAnchor,
                constant: 8)
        ])
    }
    
    @objc func saveTask() {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Task name can't be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert,animated: true)
            
            return
        }
        
        let dueOn = dueOnDatePicker.date
        viewModel.addTask(name: taskName, duoOn: dueOn)
        
        navigationController?.popViewController(animated: true)
    }
}
