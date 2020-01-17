//
//  StorybookComponentView.swift
//  AppUIKit
//
//  Created by muukii on 2019/01/27.
//  Copyright © 2019 eure. All rights reserved.
//

import UIKit

@available(*, deprecated, renamed: "StorybookComponentBasicView")
public typealias StorybookComponentView = StorybookComponentBasicView

open class StorybookComponentBasicView : UIView {
  
  public init() {
    super.init(frame: .zero)
  }
  
  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension StorybookComponentBasicView {
  
  public convenience init(
    element: UIView,
    insets: UIEdgeInsets = .init(top: 32, left: 16, bottom: 32, right: 16)
  ) {
    self.init()
    
    element.translatesAutoresizingMaskIntoConstraints = false
    addSubview(element)
    
    NSLayoutConstraint.activate([
      element.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
      element.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -insets.right),
      element.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: insets.left),
      element.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
      element.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }
  
  public convenience init(
    stretchableElement element: UIView,
    insets: UIEdgeInsets = .init(top: 32, left: 16, bottom: 32, right: 16)
  ) {
    self.init()
    
    element.translatesAutoresizingMaskIntoConstraints = false
    addSubview(element)
    
    NSLayoutConstraint.activate([
      element.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
      element.rightAnchor.constraint(equalTo: rightAnchor, constant: -insets.right),
      element.leftAnchor.constraint(equalTo: leftAnchor, constant: insets.left),
      element.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
      element.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }
}

#if canImport(AsyncDisplayKit)

import AsyncDisplayKit

extension StorybookComponentBasicView {
  
  public convenience init(
    element: ASDisplayNode,
    insets: UIEdgeInsets = .init(top: 32, left: 16, bottom: 32, right: 16)
  ) {
    self.init(element: NodeView(embedNode: element), insets: insets)
  }
}

#endif
