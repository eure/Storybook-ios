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
    public let className: String
    public let bodyView: UIView
    public let useDarkBackgroundColor: Bool
    
    public init(title: String,
                className: String,
                bodyView: StorybookComponentView,
                useDarkBackgroundColor: Bool = false) {
        self.title = title
        self.bodyView = bodyView
        self.className = className
        self.useDarkBackgroundColor = useDarkBackgroundColor
    }
}

extension StorybookComponent {
    
    public init<T>(type: T.Type, bodyView: StorybookComponentView, useDarkBackgroundColor: Bool = false) {
        self.title = String(reflecting: T.self)
        self.className = String(reflecting: T.self)
        self.bodyView = bodyView
        self.useDarkBackgroundColor = useDarkBackgroundColor
    }
    
    public init(title: String? = nil, element: UIView, useDarkBackgroundColor: Bool = false) {
        self.title = title ?? ""
        self.className = String(reflecting: type(of: element))
        self.bodyView = StorybookComponentView(element: element)
        self.useDarkBackgroundColor = useDarkBackgroundColor
    }

    public init(title: String, className: String, element: UIView, useDarkBackgroundColor: Bool = false) {
        self.title = title
        self.className = className
        self.bodyView = StorybookComponentView(element: element)
        self.useDarkBackgroundColor = useDarkBackgroundColor
    }
}

#if canImport(AsyncDisplayKit)

import AsyncDisplayKit

extension StorybookComponent {
    
    public init(title: String? = nil, element: ASDisplayNode) {
        self.title = title ?? ""
        self.className = String(reflecting: type(of: element))
        self.bodyView = StorybookComponentView(element: element)
    }
    
}

#endif
