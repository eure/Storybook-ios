//
//  MyLabel.swift
//  MyUIKit
//
//  Created by Yuka Kobayashi on 2020/01/17.
//  Copyright © 2020 eureka, Inc. All rights reserved.
//

import Foundation
import StorybookKit

class MyLabel: UIView {
  
  let label: UILabel = .init()
  
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
  
  class func makeStorybookComponents() -> BookViewType {
    BookGroup {
      BookDisplay { () -> UIView in
        self.init(title: "Hello")
      }
      .title("Short Text")

      BookDisplay { () -> UIView in
        self.init(title: "HelloHelloHelloHello")
      }
      .title("Long Text")

      BookForEach(data: 0..<10) { (i) in
        BookDisplay {
          self.init(title: "\(i)")
        }
      }
    }
  }

}
