//
//  FilledLabel.swift
//  MyUIKit
//
//  Created by Yuka Kobayashi on 2020/01/17.
//  Copyright © 2020 eureka, Inc. All rights reserved.
//

import Foundation
import StorybookKit

final class FilledLabel: MyLabel {
  
  public required init(title: String) {
    super.init(title: title)
    
    layer.borderColor = UIColor.red.cgColor
    layer.borderWidth = 1.0
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class func makeStorybookComponents() -> [StorybookComponent] {
    return [
      .init(
        title: "",
        description: String(reflecting: self),
        bodyView: StorybookComponentBasicView(
          stretchableElement: self.init(title: "HelloHello"),
          insets: .init(top: 32, left: 0, bottom: 32, right: 0)
        )
      )
    ]
  }
}
