//
//  LightLabel.swift
//  MyUIKit
//
//  Created by Yuka Kobayashi on 2020/01/17.
//  Copyright © 2020 eureka, Inc. All rights reserved.
//

import Foundation
import StorybookKit

final class LightLabel: MyLabel {
  
  public required init(title: String) {
    super.init(title: title)
    label.textColor = .init(white: 0.95, alpha: 1.0)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class func makeStorybookComponents() -> [StorybookComponent] {
    return [
      .init(element: self.init(title: "Hello"),
            backgroundColor: .init(white: 0, alpha: 0.78))
    ]
  }
}
