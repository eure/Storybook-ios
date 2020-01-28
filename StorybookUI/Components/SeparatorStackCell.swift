//
//  SeparatorStackCell.swift
//  Storybook
//
//  Created by muukii on 2019/01/26.
//  Copyright © 2019 eure. All rights reserved.
//

import UIKit

final class SeparatorView : CodeBasedView {
  
  // MARK: - Initializers
  
  init(
    leftMargin: CGFloat = 0,
    rightMargin: CGFloat = 0,
    backgroundColor: UIColor = .clear,
    separatorColor: UIColor? = nil) {
    
    super.init(frame: .zero)
    
    self.backgroundColor = backgroundColor
    let borderView = UIView()
    
    if #available(iOSApplicationExtension 13.0, *) {
      borderView.backgroundColor = separatorColor ?? .separator
    } else {
      borderView.backgroundColor = separatorColor ?? .init(white: 0, alpha: 0.1)
    }
    borderView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(borderView)
    
    let scale = UIScreen.main.scale
    let onePixel = 1 / scale

    NSLayoutConstraint.activate([
        heightAnchor.constraint(equalToConstant: 1.0)
        ])

    NSLayoutConstraint.activate([
        borderView.topAnchor.constraint(equalTo: topAnchor, constant: onePixel / scale),
        borderView.heightAnchor.constraint(equalToConstant: onePixel),
        borderView.rightAnchor.constraint(equalTo: rightAnchor, constant: rightMargin),
        borderView.leftAnchor.constraint(equalTo: leftAnchor, constant: rightMargin)
        ])
  }
  
}
