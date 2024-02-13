//
//  SummaryTableViewCell.swift
//  TaskList
//
//  Created by MacBoobPro on 02.02.24.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.backgroundColor = .secondarySystemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 20,
            leading: 20,
            bottom: 20,
            trailing: 20)
        stackView.layer.cornerRadius = 20
        stackView.clipsToBounds = true
        stackView.backgroundColor  =  .brown
        return stackView
    }()
    
    private let completedLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
       // label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let inCompletedLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
      //  label.translatesAutoresizingMaskIntoConstraints  = false
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
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(completedLabel)
        stackView.addArrangedSubview(inCompletedLabel)
        
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16),
            stackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8),
            stackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16),
            stackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -8)
        ])
    }
    
    func configure(complited: String, inComplited: String) {
        completedLabel.text = "✅ Completed: \(complited)"
        inCompletedLabel.text = "📝 TODO: \(inComplited)"
    }
    
}
