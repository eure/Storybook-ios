//
//  StorybookSectionDescriptor.swift
//  AppUIKit
//
//  Created by muukii on 2019/01/27.
//  Copyright © 2019 eure. All rights reserved.
//

import Foundation

public struct StorybookSectionDescriptor {
    
    public let title: String
    public let items: [StorybookItemDescriptor]
    public let identifier: String
    
    public init(
        title: String,
        items: [StorybookItemDescriptor],
        file: StaticString = #file,
        line: UInt = #line,
        column: UInt = #column
        ) {
        self.title = title
        self.items = items
        self.identifier = "\(file)|\(line)|\(column)"
    }
    
}
