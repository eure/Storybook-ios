//
//  StorybookComponent.swift
//  AppUIKit
//
//  Created by muukii on 2019/01/27.
//  Copyright © 2019 eure. All rights reserved.
//

import UIKit

public struct StorybookComponent {
  
  public let title: String
  public let description: String
  public let bodyView: UIView
  public let backgroundColor: UIColor?
  
  public init(
    title: String,
    description: String,
    bodyView: UIView,
    backgroundColor: UIColor? = nil
  ) {
    
    self.title = title
    self.description = description
    self.bodyView = bodyView
    self.backgroundColor = backgroundColor
  }

  @available(*, deprecated, renamed: "init(title:description:bodyView:backgroundColor:)")
  public init(
    title: String,
    className: String,
    bodyView: UIView,
    backgroundColor: UIColor? = nil
  ) {

    self.title = title
    self.description = className
    self.bodyView = bodyView
    self.backgroundColor = backgroundColor
  }
}

extension StorybookComponent {
  
  public init<T>(type: T.Type, bodyView: StorybookComponentBasicView, backgroundColor: UIColor? = nil) {
    self.title = String(reflecting: T.self)
    self.description = String(reflecting: T.self)
    self.bodyView = bodyView
    self.backgroundColor = backgroundColor
  }
  
  public init(title: String? = nil, element: UIView, backgroundColor: UIColor? = nil) {
    self.title = title ?? ""
    self.description = String(reflecting: type(of: element))
    self.bodyView = StorybookComponentBasicView(element: element)
    self.backgroundColor = backgroundColor
  }
  
  public init(title: String, description: String, element: UIView, backgroundColor: UIColor? = nil) {
    self.title = title
    self.description = description
    self.bodyView = StorybookComponentBasicView(element: element)
    self.backgroundColor = backgroundColor
  }

  @available(*, deprecated, renamed: "init(title:description:element:backgroundColor:)")
  public init(title: String, className: String, element: UIView, backgroundColor: UIColor? = nil) {
    self.title = title
    self.description = className
    self.bodyView = StorybookComponentBasicView(element: element)
    self.backgroundColor = backgroundColor
  }
}

#if canImport(AsyncDisplayKit)

import AsyncDisplayKit

extension StorybookComponent {
  
  public init(title: String? = nil, element: ASDisplayNode) {
    self.title = title ?? ""
    self.description = String(reflecting: type(of: element))
    self.bodyView = StorybookComponentView(element: element)
    self.backgroundColor = nil
  }
  
}

#endif
