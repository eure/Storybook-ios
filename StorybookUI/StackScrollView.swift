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

fileprivate final class _ScrollView: UIScrollView {
  override func touchesShouldCancel(in view: UIView) -> Bool {
    true
  }
}

class StackScrollView: UIView {

  private let innerScrollView = _ScrollView()
  private let bodyStackView = UIStackView()

  // MARK: - Initializers

  init() {
    super.init(frame: .zero)

    backgroundColor = .white

    bodyStackView.distribution = .fill
    bodyStackView.axis = .vertical
    bodyStackView.alignment = .fill

    innerScrollView.alwaysBounceVertical = true
    innerScrollView.delaysContentTouches = false
    innerScrollView.keyboardDismissMode = .interactive
    backgroundColor = .clear

    addSubview(innerScrollView)
    innerScrollView.frame = bounds
    innerScrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    innerScrollView.addSubview(bodyStackView)

    bodyStackView.translatesAutoresizingMaskIntoConstraints = false
    bodyStackView.topAnchor.constraint(equalTo: innerScrollView.topAnchor).isActive = true
    let bottom = bodyStackView.bottomAnchor.constraint(equalTo: innerScrollView.bottomAnchor)
    bottom.priority = .defaultLow
    bottom.isActive = true
    bodyStackView.leftAnchor.constraint(equalTo: innerScrollView.leftAnchor).isActive = true
    bodyStackView.rightAnchor.constraint(equalTo: innerScrollView.rightAnchor).isActive = true
    bodyStackView.widthAnchor.constraint(equalTo: innerScrollView.widthAnchor).isActive = true

  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  private(set) public var views: [UIView] = []
  
  private func identifier(_ v: UIView) -> String {
    return v.hashValue.description
  }

  func setViews(_ _views: [UIView]) {

    bodyStackView.arrangedSubviews.forEach {
      $0.removeFromSuperview()
    }

    _views.forEach {
      bodyStackView.addArrangedSubview($0)
    }
  }

}
