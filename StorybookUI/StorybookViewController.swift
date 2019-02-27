//
//  SplitViewController.swift
//  AppUIKit
//
//  Created by muukii on 2019/01/25.
//  Copyright © 2019 eure. All rights reserved.
//

import UIKit

import StorybookKit

final class StorybookViewController : UISplitViewController {
    
    private let menuController: MenuViewController
    
    private lazy var secondaryViewController = UINavigationController()
    
    init(menuDescriptor: StorybookMenuDescriptor) {
        
        self.menuController = .init(menuDescriptor: menuDescriptor)
        
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [
            UINavigationController(rootViewController: menuController),
            secondaryViewController,
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        preferredDisplayMode = .allVisible
        
    }
    
    override func showDetailViewController(_ vc: UIViewController, sender: Any?) {
        
        if isCollapsed {
            super.showDetailViewController(vc, sender: sender)
        } else {
            super.showDetailViewController(UINavigationController(rootViewController: vc), sender: sender)
        }
        
    }
}

extension StorybookViewController : UISplitViewControllerDelegate {
    
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewController.DisplayMode) {
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, show vc: UIViewController, sender: Any?) -> Bool {
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        return false
    }
    
    func splitViewControllerSupportedInterfaceOrientations(_ splitViewController: UISplitViewController) -> UIInterfaceOrientationMask {
        return .all
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        return secondaryViewController
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    func splitViewControllerPreferredInterfaceOrientationForPresentation(_ splitViewController: UISplitViewController) -> UIInterfaceOrientation {
        return .landscapeLeft
    }
}
