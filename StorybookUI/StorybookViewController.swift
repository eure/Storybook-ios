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
    
    private let menuController: MenuViewController
    
    private lazy var secondaryViewController = UINavigationController()
    
    public init(menuDescriptor: StorybookMenuDescriptor) {
        
        self.menuController = .init(menuDescriptor: menuDescriptor)
        
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [
            UINavigationController(rootViewController: menuController),
            secondaryViewController,
        ]
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
    
    public func splitViewControllerPreferredInterfaceOrientationForPresentation(_ splitViewController: UISplitViewController) -> UIInterfaceOrientation {
        return .landscapeLeft
    }
}
