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
  private let descriptionLabel = UILabel()
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
    if #available(iOS 13.0, *) {
      titleLabel.textColor = .secondaryLabel
    } else {
      titleLabel.textColor = .init(white: 0, alpha: 0.6)
    }
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    
    descriptionLabel.numberOfLines = 0
    if #available(iOS 13.0, *) {
      descriptionLabel.textColor = .tertiaryLabel
    } else {
      titleLabel.textColor = .init(white: 0, alpha: 0.4)
    }
    descriptionLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    
    do {
      
      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
      
      titleContainerView.addSubview(titleLabel)
      titleContainerView.addSubview(descriptionLabel)
      
      NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 8.0),
        titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 16.0),
        titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -16.0)
      ])
      
      NSLayoutConstraint.activate([
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
        descriptionLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 16.0),
        descriptionLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -16.0),
        descriptionLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: -8.0),
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
  
  func set(description: String) {
    descriptionLabel.text = description
  }
  
  func set(backgroundColor: UIColor) {
    contentView.backgroundColor = backgroundColor
  }
}

extension ContainerStackCell {
  
  convenience init(
    bodyView: UIView,
    title: String,
    description: String,
    backgroundColor: UIColor?
  ) {
    
    self.init()
    
    set(title: title)
    set(description: description)

    if #available(iOS 13.0, *) {
      set(backgroundColor: backgroundColor ?? .secondarySystemBackground)
    } else {
      set(backgroundColor: backgroundColor ?? .init(white: 0, alpha: 0.02))
    }
    
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
