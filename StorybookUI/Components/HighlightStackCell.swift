//
//  HighlightStackCell.swift
//  StorybookUI
//
//  Created by Yuka Kobayashi on 2020/01/17.
//  Copyright © 2020 eureka, Inc. All rights reserved.
//

import Foundation

class HighlightStackCell : TapStackCell {
  
  // MARK: - Properties
  
  override var isHighlighted: Bool {
    didSet {
      // TODO:
    }
  }
  
  // MARK: - Initializers
  
  override init() {
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
