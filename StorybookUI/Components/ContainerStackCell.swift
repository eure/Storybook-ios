//
//  ContainerStackCell.swift
//  Storybook
//
//  Created by muukii on 2019/01/26.
//  Copyright © 2019 eure. All rights reserved.
//

import Foundation

final class ContainerStackCell : CodeBasedView, StackCellType {
    
    private let titleContainerView = UIView()
    let contentView = UIView()
    
    private let titleLabel = UILabel()
    private let classNameLabel = UILabel()
    private let titleContainerViewViewShapeLayer = CAShapeLayer()
    private let contentViewShapeLayer = CAShapeLayer()
    
    init() {
        super.init(frame: .zero)
        
        layer.addSublayer(titleContainerViewViewShapeLayer)
        layer.addSublayer(contentViewShapeLayer)
        
        titleContainerViewViewShapeLayer.fillColor = UIColor(white: 0, alpha: 0.03).cgColor
        contentViewShapeLayer.fillColor = UIColor(white: 0, alpha: 0.02).cgColor
        
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleContainerView)
        addSubview(contentView)
        
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor(white: 0, alpha: 0.6)
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        classNameLabel.numberOfLines = 0
        classNameLabel.textColor = UIColor(white: 0, alpha: 0.4)
        classNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        do {
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            classNameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            titleContainerView.addSubview(titleLabel)
            titleContainerView.addSubview(classNameLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 8.0),
                titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 16.0),
                titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -16.0)
                ])
            
            NSLayoutConstraint.activate([
                classNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
                classNameLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 16.0),
                classNameLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -16.0),
                classNameLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: -8.0),
                ])
        }
        
        
        NSLayoutConstraint.activate([
            titleContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            titleContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
            ])
        
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
            ])
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    func set(className: String) {
        classNameLabel.text = className
    }
    
    func set(backgroundColor: UIColor) {
        contentView.backgroundColor = backgroundColor
    }
}

extension ContainerStackCell {
    
    convenience init(
        bodyView: UIView,
        title: String,
        className: String,
        backgroundColor: UIColor?
        ) {
        
        self.init()
        
        set(title: title)
        set(className: className)
        set(backgroundColor: backgroundColor ?? .init(white: 0, alpha: 0.02))
        
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bodyView)
        
        NSLayoutConstraint.activate([
            bodyView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bodyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bodyView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bodyView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
            ])
    }
    
}
