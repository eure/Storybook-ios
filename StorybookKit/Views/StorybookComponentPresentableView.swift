//
//  StorybookComponentPresentableView.swift
//  StorybookKit
//
//  Created by muukii on 2020/05/16.
//  Copyright © 2020 eureka, Inc. All rights reserved.
//

import Foundation

open class StorybookComponentPresentableView: UIView {

  private let presentButton: UIButton
  private let presentedViewControllerBlock: () -> UIViewController

  public init(title: String, presentedViewControllerBlock: @escaping () -> UIViewController) {

    self.presentButton = UIButton(type: .system)
    self.presentedViewControllerBlock = presentedViewControllerBlock

    super.init(frame: .zero)

    self.presentButton.setTitle(title, for: .normal)
    self.presentButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
    self.presentButton.addTarget(self, action: #selector(onTapPresentButton), for: .touchUpInside)

    addSubview(presentButton)

    presentButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([

      presentButton.topAnchor.constraint(equalTo: topAnchor, constant: 32.0),
      presentButton.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -layoutMargins.right),
      presentButton.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: layoutMargins.left),
      presentButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 32.0),

    ])
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc
  private func onTapPresentButton() {

    let presentingViewControllerCandidate = sequence(first: next, next: { $0?.next }).first { $0 is UIViewController } as? UIViewController

    guard let presentingViewController = presentingViewControllerCandidate else {
      assertionFailure()
      return
    }

    let viewController = presentedViewControllerBlock()

    presentingViewController.present(viewController, animated: true, completion: nil)

  }
}
