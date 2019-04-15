//
//  StorybookComponentInteractiveView.swift
//  StorybookKit
//
//  Created by muukii on 2019/04/15.
//

import Foundation

open class StorybookComponentInteractiveView : UIView {
  
  // MARK: - Properties
  
  private let stackView: UIStackView = .init()
  
  // MARK: - Initializers
  
  public init(element: UIView, actionDiscriptors: [ActionDescriptor]) {
    
    super.init(frame: .zero)
    
    stack: do {
      
      stackView.distribution = .equalSpacing
      stackView.spacing = 8
      stackView.axis = .horizontal
      stackView.alignment = .fill
      stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
      
      actionDiscriptors.forEach { descriptor in
        
        let button = ActionButton(type: .system)
        
        button.setTitle(descriptor.title, for: .normal)
        button.addTarget(self, action: #selector(actionButtonTouchUpInside), for: .touchUpInside)
        button.action = descriptor.action
        
        stackView.addArrangedSubview(button)
        
      }
      
    }
    
    addSubview(element)
    addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    element.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      
      element.topAnchor.constraint(equalTo: topAnchor, constant: 32.0),
      element.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -16.0),
      element.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 16.0),
      element.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      stackView.topAnchor.constraint(equalTo: element.bottomAnchor, constant: 32.0),
      stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
      stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      ])
    
  }
  
  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc
  private func actionButtonTouchUpInside(button: ActionButton) {
    button.action()
  }
  
  // MARK: - Nested types
  
  private final class ActionButton : UIButton {
    var action: () -> Void = {}
  }
  
}

extension StorybookComponentInteractiveView {
  
  public struct ActionDescriptor {
    
    // MARK: - Properties
    public let title: String
    
    public let action: () -> Void
    
    // MARK: - Initializers
    
    public init(title: String, action: @escaping () -> Void) {
      
      self.title = title
      self.action = action
    }
  }
  
}
