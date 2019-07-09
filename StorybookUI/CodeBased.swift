//
//  CodeBasedViewController.swift
//  Storybook
//
//  Created by muukii on 2019/01/25.
//  Copyright © 2019 eure. All rights reserved.
//

import UIKit

class CodeBasedView : UIView {
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class CodeBasedViewController : UIViewController {
  
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
