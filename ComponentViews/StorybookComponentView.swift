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

extension StorybookComponentView {
    
    public convenience init(element: UIView) {
        self.init()
        
        addSubview(element)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            element.topAnchor.constraint(equalTo: topAnchor, constant: 32.0),
            element.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -16.0),
            element.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 16.0),
            element.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32.0),
            element.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
}

#if canImport(AsyncDisplayKit)

import AsyncDisplayKit

extension StorybookComponentView {
    
    public convenience init(element: ASDisplayNode) {
        self.init(element: NodeView(embedNode: element))
    }
}

#endif
