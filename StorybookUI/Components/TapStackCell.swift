//
//  TapStackCell.swift
//  StorybookUI
//
//  Created by muukii on 2019/02/27.
//  Copyright © 2019 eureka, Inc. All rights reserved.
//

import UIKit

class TapStackCell : UIControl, StackCellType {
  
  // MARK: - Properties
  
  override var isHighlighted: Bool {
    get {
      
      return super.isHighlighted
    }
    set {
      
      super.isHighlighted = newValue
      
      UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
        
        if newValue {

          if #available(iOS 13.0, *) {

            self.backgroundColor = .systemFill
          } else {

            self.backgroundColor = .init(white: 0.95, alpha: 1)
          }
        } else {
          
          self.backgroundColor = .clear
        }
      }) { (finish) in
      }
    }
  }
  
  
  // MARK: - Initializers
  
  init() {
    super.init(frame: .zero)
    
    addTarget(self, action: #selector(TapStackCell.tapSelf), for: .touchUpInside)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Functions
  
  @objc
  private func tapSelf() {
    tapped()
  }
  
  func tapped() {
    
  }
}
