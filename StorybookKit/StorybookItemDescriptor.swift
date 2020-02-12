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
  public let identifier: String
  
  public init(
    title: String,
    detail: String,
    components: @escaping () -> [StorybookComponent],
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column
  ) {
    self.title = title
    self.detail = detail
    self.componentsFactory = components
    self.identifier = "\(file)|\(line)|\(column)"
  }
  
  public init(
    title: String,
    detail: String = "",
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column,
    @StorybookBuilder<StorybookComponent> _ component: @escaping () -> StorybookComponent
  ) {
    self.init(title: title,
              detail: detail,
              components: { [component()] },
              file: file,
              line: line,
              column: column)
  }
  
  public init(
    title: String,
    detail: String = "",
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column,
    @StorybookBuilder<StorybookComponent> _ components: @escaping () -> [StorybookComponent]
  ) {
    self.init(title: title,
              detail: detail,
              components: components,
              file: file,
              line: line,
              column: column)
  }
}
