//
//  ToDoTableViewCell.swift
//  TaskList
//
//  Created by MacBoobPro on 31.01.24.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    private let taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let dueOrCompletedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let completedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        selectionStyle = .none
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(dueOrCompletedLabel)
        contentView.addSubview(completedLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8),
            taskNameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16),
            taskNameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16),
            dueOrCompletedLabel.topAnchor.constraint(
                equalTo: taskNameLabel.bottomAnchor,
                constant: 16),
            dueOrCompletedLabel.leadingAnchor.constraint(
                equalTo: taskNameLabel.leadingAnchor),
            dueOrCompletedLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16/2),
            
            completedLabel.topAnchor.constraint(
                equalTo: taskNameLabel.bottomAnchor,
                constant: 16),
            completedLabel.trailingAnchor.constraint(
                equalTo: taskNameLabel.trailingAnchor),
            completedLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16/2),
            
            contentView.bottomAnchor.constraint(
                greaterThanOrEqualTo: taskNameLabel.bottomAnchor,
                constant:  8)
        ])
    }
    
    func configure(task: TaskViewModel) {
        let attributedString = NSMutableAttributedString(string: task.name)
        
        if task.completed {
            attributedString.addAttribute(
                NSAttributedString.Key.strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSMakeRange(0, attributedString.length))
            taskNameLabel.font = UIFont.italicSystemFont(ofSize: 16)
        } else {
            taskNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        }
        
        taskNameLabel.attributedText = attributedString
        dueOrCompletedLabel.text = task.completed
        ? "Completed on \(task.completedOn.formatted(date: .abbreviated, time: .omitted))"
        :  "Due on: \(task.completedOn.formatted(date: .abbreviated, time: .omitted))"
        
        completedLabel.text = task.completed ? "Completed" : "Not Completed"
        completedLabel.textColor = task.completed ? .green : .red
    }
    
}
