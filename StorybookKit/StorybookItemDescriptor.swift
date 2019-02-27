//
//  StorybookItemDescriptor.swift
//  AppUIKit
//
//  Created by muukii on 2019/01/27.
//  Copyright © 2019 eure. All rights reserved.
//

import Foundation

public struct StorybookItemDescriptor {
  
  public let title: String
  public let detail: String
  public let componentsFactory: () -> [StorybookComponent]
  
  public init(
    title: String,
    detail: String,
    components: @escaping () -> [StorybookComponent]
    ) {
    self.title = title
    self.detail = detail
    self.componentsFactory = components
  }
  
}
