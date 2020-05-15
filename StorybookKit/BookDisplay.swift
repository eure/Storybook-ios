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

import Foundation

/// A component descriptor that just displays UI-Component
public struct BookDisplay: BookViewPresentableType {

  public let viewBlock: () -> UIView

  public var backgroundColor: UIColor = {
    if #available(iOS 13.0, *) {
      return .systemBackground
    } else {
      return .white
    }
  }()

  public init(viewBlock: @escaping () -> UIView) {
    self.viewBlock = viewBlock
  }

  public func asTree() -> BookTree {
    .element(AnyBookView(self))
  }

  public func title(_ text: String) -> BookGroup {
    .init {
      BookText(text)
      self
    }
  }

  public func backgroundColor(_ color: UIColor) -> Self {
    modified {
      $0.backgroundColor = color
    }
  }

  public func makeView() -> UIView {
    let view = _View(stretchableElement: viewBlock())
    view.backgroundColor = backgroundColor
    return view
  }

  private final class _View : UIView {

    public init() {
      super.init(frame: .zero)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    public convenience init(
      element: UIView,
      insets: UIEdgeInsets = .init(top: 32, left: 16, bottom: 32, right: 16)
    ) {
      self.init()

      element.translatesAutoresizingMaskIntoConstraints = false
      addSubview(element)

      NSLayoutConstraint.activate([
        element.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
        element.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -insets.right),
        element.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: insets.left),
        element.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
        element.centerXAnchor.constraint(equalTo: centerXAnchor)
      ])
    }

    public convenience init(
      stretchableElement element: UIView,
      insets: UIEdgeInsets = .init(top: 32, left: 16, bottom: 32, right: 16)
    ) {
      self.init()

      element.translatesAutoresizingMaskIntoConstraints = false
      addSubview(element)

      NSLayoutConstraint.activate([
        element.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
        element.rightAnchor.constraint(equalTo: rightAnchor, constant: -insets.right),
        element.leftAnchor.constraint(equalTo: leftAnchor, constant: insets.left),
        element.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
        element.centerXAnchor.constraint(equalTo: centerXAnchor)
      ])
    }
  }

}
