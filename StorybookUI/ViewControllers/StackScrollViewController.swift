//
//  StackScrollViewController.swift
//  Storybook
//
//  Created by muukii on 2019/01/26.
//  Copyright © 2019 eure. All rights reserved.
//

import Foundation

import StorybookKit

final class StackScrollViewController : CodeBasedViewController {
  
  private let stackScrollView = StackScrollView()
  
  init(views: [UIView]) {
    super.init()
    stackScrollView.append(views: views)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if #available(iOSApplicationExtension 13.0, *) {
      view.backgroundColor = .systemBackground
    } else {
      view.backgroundColor = .white
    }
    
    view.addSubview(stackScrollView)
    stackScrollView.frame = view.bounds
    stackScrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
  }
  
}

extension StackScrollViewController {
  
  convenience init(descriptor: StorybookItemDescriptor) {
    
    self.init(views: [
      {
        let view = HeaderStackCell()
        view.set(title: descriptor.title)
        view.set(detail: descriptor.detail)
        return view
      }(),
      ] + descriptor.makeCells()
    )
  }
}
