//
// Copyright (c) 2020 Eureka, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

final class ActionCell: UIView {

  private let actionButton: UIButton
  private let action: (UIViewController) -> Void

  public init(
    title: String,
    action: @escaping (UIViewController) -> Void
  ) {

    self.actionButton = UIButton(type: .system)
    self.action = action

    super.init(frame: .zero)

    self.actionButton.setTitle("⇪ \(title)", for: .normal)
    self.actionButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
    self.actionButton.addTarget(self, action: #selector(onTapPresentButton), for: .touchUpInside)

    addSubview(actionButton)

    actionButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([

      actionButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      actionButton.rightAnchor.constraint(
        lessThanOrEqualTo: rightAnchor,
        constant: -layoutMargins.right
      ),
      actionButton.leftAnchor.constraint(
        greaterThanOrEqualTo: leftAnchor,
        constant: layoutMargins.left
      ),
      actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
      actionButton.centerXAnchor.constraint(equalTo: centerXAnchor),

    ])
  }

  public required init?(
    coder: NSCoder
  ) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc
  private func onTapPresentButton() {

    let presentingViewControllerCandidate =
      sequence(first: next, next: { $0?.next }).first { $0 is UIViewController }
      as? UIViewController

    guard let presentingViewController = presentingViewControllerCandidate else {
      assertionFailure()
      return
    }

    action(presentingViewController)
  }
}
