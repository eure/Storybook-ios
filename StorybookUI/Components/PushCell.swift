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

import MondrianLayout
import UIKit

final class PushCell: UIView {

  enum Action {
    case onSelected
  }

  public let actionHandler: (Action) -> Void

  private let pushButton: UIButton
  private let pushingViewControllerBlock: () -> UIViewController

  init(
    title: String,
    actionHandler: @escaping (Action) -> Void,
    pushingViewControllerBlock: @escaping () -> UIViewController
  ) {

    self.pushButton = UIButton(type: .system)
    self.pushingViewControllerBlock = pushingViewControllerBlock
    self.actionHandler = actionHandler

    super.init(frame: .zero)

    self.pushButton.setTitle("\(title) →", for: .normal)
    self.pushButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
    self.pushButton.titleLabel?.numberOfLines = 0
    self.pushButton.addTarget(self, action: #selector(onTapPushButton), for: .touchUpInside)

    Mondrian.buildSubviews(on: self) {
      ZStackBlock {
        pushButton
          .viewBlock
          .padding(.vertical, 16)
          .padding(.horizontal, 24)
      }
    }

  }

  public required init?(
    coder: NSCoder
  ) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc
  private func onTapPushButton() {

    let presentingViewControllerCandidate =
      sequence(first: next, next: { $0?.next }).first { $0 is UIViewController }
      as? UIViewController

    guard let navigationController = presentingViewControllerCandidate?.navigationController else {
      assertionFailure()
      return
    }

    actionHandler(.onSelected)

    let viewController = pushingViewControllerBlock()

    navigationController.pushViewController(viewController, animated: true)

  }
}
