
//
//  Extensions.swift
//  AppUIKit
//
//  Created by muukii on 2019/01/27.
//  Copyright © 2019 eure. All rights reserved.
//

import Foundation

import StorybookKit

extension StorybookItemDescriptor {
  
  func makeCells() -> [UIView] {
    
    return componentsFactory().map {
      ContainerStackCell(bodyView: $0.bodyView, title: $0.title, className: $0.className)
    }
  }
}
