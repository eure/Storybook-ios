//
//  StorybookDefinition.swift
//  MyUIKit
//
//  Created by muukii on 2019/02/27.
//  Copyright © 2019 eureka, Inc. All rights reserved.
//

import Foundation
import StorybookKit

public let __storybookMenuDescriptor = StorybookMenuDescriptor {
  StorybookSectionDescriptor("Sample Section") {
    StorybookItemDescriptor(
      title: "Labels",
      detail: "A description of labels"
    ) {
      MyLabel.makeStorybookComponents()
      LightLabel.makeStorybookComponents()
      FilledLabel.makeStorybookComponents()
    }
  }
}
