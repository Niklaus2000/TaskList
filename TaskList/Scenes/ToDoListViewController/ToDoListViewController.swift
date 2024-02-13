//
//  ViewController.swift
//  TaskList
//
//  Created by MacBoobPro on 21.01.24.
//

import UIKit

//class ToDoListViewController: UIViewController {
//
//    private lazy var addNewTaskButton: UIButton = {
//        var button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("add Task", for: .normal)
//        button.addTarget(self, action: #selector(addNewTask(sender: )) , for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var getTaskButton: UIButton = {
//        var button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("get Tasks", for: .normal)
//        button.addTarget(self, action: #selector(getTasks(sender: )) , for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var toggleCompletedButton: UIButton = {
//        var button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Mark Task Completed", for: .normal)
//        button.addTarget(self, action: #selector(getMarkedCompleted(sender: )) , for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var deleteTaskButton: UIButton = {
//        var button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Delete Task", for: .normal)
//        button.addTarget(self, action: #selector(deleteTask(sender: )) , for: .touchUpInside)
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        title = "ToDoList"
//        view.backgroundColor = UIColor.systemBackground
//
//        [
//            addNewTaskButton,
//            getTaskButton,
//            toggleCompletedButton,
//            deleteTaskButton].forEach { control in
//                view.addSubview(control)
//            }
//
//        NSLayoutConstraint.activate([
//            addNewTaskButton.topAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.topAnchor,
//                constant: 16),
//            addNewTaskButton.leadingAnchor.constraint(
//                equalTo: view.leadingAnchor,
//                constant: 16),
//            addNewTaskButton.trailingAnchor.constraint(
//                equalTo: view.trailingAnchor,
//                constant: -16),
//            getTaskButton.topAnchor.constraint(
//                equalTo: addNewTaskButton.bottomAnchor,
//                constant: 8),
//            getTaskButton.leadingAnchor.constraint(
//                equalTo: view.leadingAnchor,
//                constant: 16),
//            getTaskButton.trailingAnchor.constraint(
//                equalTo: view.trailingAnchor,
//                constant: -16),
//            toggleCompletedButton.topAnchor.constraint(
//                equalTo: getTaskButton.bottomAnchor,
//                constant: 16),
//            toggleCompletedButton.leadingAnchor.constraint(
//                equalTo: view.leadingAnchor,
//                constant: 16),
//            toggleCompletedButton.trailingAnchor.constraint(
//                equalTo: view.trailingAnchor,
//                constant: -16),
//            deleteTaskButton.topAnchor.constraint(
//                equalTo: toggleCompletedButton.bottomAnchor,
//                constant: 16),
//            deleteTaskButton.leadingAnchor.constraint(
//                equalTo: view.leadingAnchor,
//                constant: 16),
//            deleteTaskButton.trailingAnchor.constraint(
//                equalTo: view.trailingAnchor,
//                constant: -16),
//        ])
//    }
//
//    // MARK: Action Function
//    @objc
//    func addNewTask(sender: UIButton) {
//       var coredata = CoreDataManager.shared.addNewTask(name: "A new task", dueOn: Date().addingTimeInterval(100000))
//    }
//
//    @objc
//    func getTasks(sender: UIButton) {
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks {
//            print(task.name ?? "")
//        }
//    }
//
//    @objc
//    func getMarkedCompleted(sender: UIButton) {
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks {
//            CoreDataManager.shared.delete(id: UUID())
//        }
//
//        let fetchedTasks = CoreDataManager.shared.getAll()
//
//        for task in tasks {
//            print("\(task.name ?? ""): \(task.completed), \(task.completedOn?.formatted(date: .abbreviated, time: .omitted) ?? "")")
//        }
//    }
//
//    @objc
//    func deleteTask(sender: UIButton) {
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks {
//            CoreDataManager.shared.toggleCompleted(id: task.id ?? UUID())
//        }
//
//        let fetchedTasks = CoreDataManager.shared.getAll()
//        print(fetchedTasks.count)
//        for task in tasks {
//            print("\(task.name ?? ""): \(task.completed), \(task.completedOn?.formatted(date: .abbreviated, time: .omitted) ?? "")")
//        }
//    }
//}


class ToDoListViewController: UIViewController {
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        tableView.register(SummaryTableViewCell.self, forCellReuseIdentifier: "SummaryCell")
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    var celebrationAnimationView: CelebrationAnnimationView = {
        let view = CelebrationAnnimationView(fileName: "Celebration")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let viewModel = TaskListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ToDoList"
        view.backgroundColor = UIColor.systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
        ])
        
        view.addSubview(celebrationAnimationView)
        NSLayoutConstraint.activate([
            celebrationAnimationView.topAnchor.constraint(
                equalTo: view.topAnchor),
            celebrationAnimationView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            celebrationAnimationView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            celebrationAnimationView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
        ])
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        celebrationAnimationView.play { finished in
//            print("Done playing animation")
//        }
//    }
    
    @objc func addNewTask() {
        navigationController?.pushViewController(AddNewTaskViewController(), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getAll()
        tableView.reloadData()
    }
}

