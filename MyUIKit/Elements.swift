//
//  Elements.swift
//  MyUIKit
//
//  Created by muukii on 2019/02/27.
//  Copyright © 2019 eureka, Inc. All rights reserved.
//

import Foundation

import StorybookKit

public enum Elements {
    
    public class MyLabel : UIView {
        
        fileprivate let label: UILabel = .init()
        
        public required init(title: String) {
            super.init(frame: .zero)
            label.text = title
            
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
                label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
                label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0)
                ])
            
        }
        
        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        class func makeStorybookComponent(title: String) -> StorybookComponent {
            
            let element = self.init(title: title)

            return StorybookComponent(element: element)
        }
    }

    public final class LightLabel : MyLabel {

        public required init(title: String) {
            super.init(title: title)
            label.textColor = .init(white: 0.95, alpha: 1.0)
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override class func makeStorybookComponent(title: String) -> StorybookComponent {

            let element = self.init(title: title)

            return StorybookComponent(element: element,
                                      backgroundColor: .init(white: 0, alpha: 0.78))
        }
    }
    
    public final class FilledLabel : MyLabel {
        
        public required init(title: String) {
            super.init(title: title)
            backgroundColor = .init(white: 0, alpha: 0.48)
            
            label.textColor = .init(white: 0.95, alpha: 1.0)
        }
        
        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override class func makeStorybookComponent(title: String) -> StorybookComponent {
            
            let element = self.init(title: title)
            NSLayoutConstraint.activate([
                element.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
                ])

            return StorybookComponent(
                title: "",
                className: String(reflecting: type(of: element).self),
                bodyView: StorybookComponentBasicView(
                    element: element,
                    insets: .init(top: 32, left: 0, bottom: 32, right: 0)
                )
            )
        }
    }
}
