//
//  ViewController.swift
//  Demo
//
//  Created by muukii on 2019/02/27.
//  Copyright © 2019 eureka, Inc. All rights reserved.
//

import UIKit

import MyUIKit
import StorybookUI

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }

  @IBAction private func didTapPresentButton(_ sender: Any) {
  
    let controller = StorybookViewController(menuDescriptor: __storybookMenuDescriptor, showDismissButton: true)
    
    present(controller, animated: true, completion: nil)
    
  }
  
}

