//
//  StorybookMenuDescriptor.swift
//  AppUIKit
//
//  Created by muukii on 2019/01/27.
//  Copyright © 2019 eure. All rights reserved.
//

import Foundation

public struct StorybookMenuDescriptor {
  
  public let sections: [StorybookSectionDescriptor]
  public let identifier: String
  
  public init(
    sections: [StorybookSectionDescriptor],
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column
  ) {
    self.sections = sections
    self.identifier = "\(file)|\(line)|\(column)"
  }
  
  public init(
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column,
    @StorybookBuilder<StorybookSectionDescriptor> _ section: () -> StorybookSectionDescriptor
  ) {
    self.init(sections: [section()], file: file, line: line, column: column)
  }
  
  public init(
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column,
    @StorybookBuilder<StorybookSectionDescriptor> _ sections: () -> [StorybookSectionDescriptor]
  ) {
    self.init(sections: sections(), file: file, line: line, column: column)
  }
}
