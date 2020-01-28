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
    label.textColor = .lightText
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class func makeStorybookComponents() -> [StorybookComponent] {
    return [
      .init(element: self.init(title: "Hello"),
            backgroundColor: .black)
    ]
  }
}
