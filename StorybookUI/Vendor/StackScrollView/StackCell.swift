//
//  StackCell.swift
//  StackScrollView
//
//  Created by muukii on 5/2/17.
//  Copyright © 2017 muukii. All rights reserved.
//

import Foundation

// MARK: Beta
class StackCell: UIView, StackCellType {
  
  var shouldAnimateLayoutChanges: Bool = true
  
  override func invalidateIntrinsicContentSize() {
    super.invalidateIntrinsicContentSize()
    updateLayout(animated: shouldAnimateLayoutChanges)
  }
}
