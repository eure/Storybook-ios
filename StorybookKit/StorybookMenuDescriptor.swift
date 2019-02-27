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
    
    public init(
        sections: [StorybookSectionDescriptor]
        ) {
        self.sections = sections
    }
    
}
