//
//  MenuViewController.swift
//  Storybook
//
//  Created by muukii on 2019/01/25.
//  Copyright © 2019 eure. All rights reserved.
//

import UIKit

import StorybookKit

final class MenuViewController : CodeBasedViewController {
    
    private let stackScrollView = StackScrollView()
    
    private let menuDescriptor: StorybookMenuDescriptor
    
    init(menuDescriptor: StorybookMenuDescriptor) {
        
        self.menuDescriptor = menuDescriptor
        
        super.init()
        
        title = "Storybook"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        stackScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackScrollView)
        
        NSLayoutConstraint.activate([
            stackScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            stackScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        do {
            
            let views: [UIView] = menuDescriptor.sections.flatMap { section in
                [
                    SectionCell(title: section.title) { },
                    SeparatorView(leftMargin: 16, rightMargin: 0, backgroundColor: .white, separatorColor: UIColor(white: 0, alpha: 0.1))
                    ] +
                    section.items.flatMap { item in
                        [
                            ItemCell(title: item.title) { [weak self] in
                                self?.showDetailViewController(StackScrollViewController(descriptor: item), sender: self)
                            },
                            SeparatorView(leftMargin: 32, rightMargin: 0, backgroundColor: .white, separatorColor: UIColor(white: 0, alpha: 0.1))
                        ]
                }
            }
            
            stackScrollView.append(views: views)
            
        }
        
    }
}

extension MenuViewController {
    
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
    
    final class SectionCell : TapStackCell {
        
        // MARK: - Properties
        
        private let titleLabel = UILabel()
        
        private let didTapAction: () -> Void
        
        // MARK: - Initializers
        
        init(title: String, didTap: @escaping () -> Void = {}) {
            
            self.didTapAction = didTap
            super.init()
            
            titleLabel.numberOfLines = 0
            titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            
            backgroundColor = .white
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16.0),
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0)
                ])
            
            set(title: title)

            
            addTarget(self, action: #selector(_didTap), for: .touchUpInside)

        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Functions
        
        func set(title: String) {
            titleLabel.text = title
        }
        
        @objc private dynamic func _didTap() {
            didTapAction()
        }
        
    }
    
    final class ItemCell : HighlightStackCell {
        
        // MARK: - Properties
        
        private let titleLabel = UILabel()
        
        private let didTapAction: () -> Void
        
        // MARK: - Initializers
        
        init(title: String, didTap: @escaping () -> Void = {}) {
            
            self.didTapAction = didTap
            super.init()
            
            addTarget(self, action: #selector(_didTap), for: .touchUpInside)
            
            
            titleLabel.numberOfLines = 0
            titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
            
            backgroundColor = .white
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32.0),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
                titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16.0)
                ])
            
            set(title: title)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Functions
        
        func set(title: String) {
            titleLabel.text = title
        }
        
        @objc private dynamic func _didTap() {
            didTapAction()
        }
        
    }
    
}
