//
//  SplitViewController.swift
//  AppUIKit
//
//  Created by muukii on 2019/01/25.
//  Copyright © 2019 eure. All rights reserved.
//

import UIKit

import StorybookKit

public final class StorybookViewController : UISplitViewController {
  
  public typealias DismissHandler = (StorybookViewController) -> Void
  
  private let mainViewController: UINavigationController
  
  private let secondaryViewController = UINavigationController()
  
  private let dismissHandler: DismissHandler?
  
  
  /// Initializer
  ///
  /// - Parameters:
  ///   - menuDescriptor:
  ///   - dismissHandler: A closure to handle event for touch-up-inside on DismissButton. If you set nil, dismiss button will be disappear.
  public init(menuDescriptor: StorybookMenuDescriptor, dismissHandler: DismissHandler?) {
    
    let menuController = MenuViewController.init(menuDescriptor: menuDescriptor)
    self.mainViewController = UINavigationController(rootViewController: menuController)
    
    self.dismissHandler = dismissHandler
    
    super.init(nibName: nil, bundle: nil)
    
    if dismissHandler != nil {
      let dismissButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDismissButton))
      menuController.navigationItem.leftBarButtonItem = dismissButton
    }
    
    viewControllers = [
      mainViewController,
      secondaryViewController,
    ]
    
  }
  
  @available(*, deprecated, message: "Use init(menuDescriptor: StorybookMenuDescriptor, dismissHandler: DismissHandler?) instead")
  public convenience init(menuDescriptor: StorybookMenuDescriptor, showDismissButton: Bool) {
    
    self.init(menuDescriptor: menuDescriptor, dismissHandler: { v in
      v.dismiss(animated: true, completion: nil)
    })
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    delegate = self
    preferredDisplayMode = .allVisible
    
  }
  
  public override func showDetailViewController(_ vc: UIViewController, sender: Any?) {
    
    if isCollapsed {
      super.showDetailViewController(vc, sender: sender)
    } else {
      super.showDetailViewController(UINavigationController(rootViewController: vc), sender: sender)
    }
    
  }
  
  @objc private func didTapDismissButton() {
    dismissHandler?(self)
  }
  
  public override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    
    if #available(iOS 13.0, *) {
      if motion == .motionShake {
        didShake()
      }
    }
  }
  
  @available(iOS 13.0, *)
  private func didShake() {

    let currentStyle: String = {      
      switch overrideUserInterfaceStyle {
      case .light: return "Light"
      case .dark: return "Dark"
      case .unspecified: break
      @unknown default: break
      }
      
      switch traitCollection.userInterfaceStyle {
      case .light: return "System (Light)"
      case .dark: return "System (Dark)"
      case .unspecified: return "System (Unspecified)"
      @unknown default: return "System (Unspecified)"
      }
    }()

    let c = UIAlertController(title: "User Interface Style",
                              message: "current: \(currentStyle)",
                              preferredStyle: .actionSheet)
    
    c.addAction(.init(
      title: "System",
      style: .default,
      handler: { _ in self.overrideUserInterfaceStyle = .unspecified }
      ))

    c.addAction(.init(
      title: "Light",
      style: .default,
      handler: { _ in self.overrideUserInterfaceStyle = .light }
      ))

    c.addAction(.init(
      title: "Dark",
      style: .default,
      handler: { _ in self.overrideUserInterfaceStyle = .dark }
      ))

    c.addAction(.init(title: "Cancel", style: .cancel))
    present(c, animated: true)
  }
}

extension StorybookViewController : UISplitViewControllerDelegate {
  
  public func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewController.DisplayMode) {
  }
  
  public func splitViewController(_ splitViewController: UISplitViewController, show vc: UIViewController, sender: Any?) -> Bool {
    return true
  }
  
  public func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
    return false
  }
  
  public func splitViewControllerSupportedInterfaceOrientations(_ splitViewController: UISplitViewController) -> UIInterfaceOrientationMask {
    return .all
  }
  
  public func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
    return secondaryViewController
  }
  
  public func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    return true
  }
}
