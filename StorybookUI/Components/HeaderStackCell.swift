//
//  HeaderStackCell.swift
//  Storybook
//
//  Created by muukii on 2019/01/26.
//  Copyright © 2019 eure. All rights reserved.
//

import UIKit

final class HeaderStackCell : CodeBasedView {
  
  private let titleLabel = UILabel()
  
  private let detailLabel = UILabel()
  
  init() {
    super.init(frame: .zero)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    detailLabel.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(titleLabel)
    addSubview(detailLabel)
    
    titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
    titleLabel.numberOfLines = 0
    
    detailLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    detailLabel.textColor = UIColor(white: 0, alpha: 0.4)
    detailLabel.numberOfLines = 0

    NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0)
        ])

    NSLayoutConstraint.activate([
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
        detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
        detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0)
        ])
  }
  
  func set(title: String) {
    titleLabel.text = title
  }
  
  func set(detail: String) {
    detailLabel.text = detail
  }

}
