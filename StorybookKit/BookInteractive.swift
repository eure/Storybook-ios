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

/// A component descriptor that can control a UI-Component with specified button.
public struct BookInteractive<View: UIView>: BookViewRepresentableType {

  public let viewBlock: () -> View

  public var backgroundColor: UIColor = {
    if #available(iOS 13.0, *) {
      return .systemBackground
    } else {
      return .white
    }
  }()
  
  private var buttons: ContiguousArray<(title: String, handler: (View) -> Void)> = .init()

  public init(viewBlock: @escaping () -> View) {
    self.viewBlock = viewBlock
  }

  public func addButton(_ title: String, handler: @escaping (View) -> Void) -> Self {
    modified {
      $0.buttons.append((title: title, handler: handler))
    }
  }

  public func makeView() -> UIView {
    let view = _View(
      element: viewBlock(),
      actionDiscriptors: buttons.map {
        _View.ActionDescriptor(title: $0.title, action: $0.handler)
    })
    view.backgroundColor = backgroundColor
    return view
  }

  public func title(_ text: String) -> BookGroup {
    .init {
      BookText(text)
      self
    }
  }

}

fileprivate final class _View : UIView {

  // MARK: - Properties

  private let stackView: UIStackView = .init()

  // MARK: - Initializers

  public init<T: UIView>(element: T, actionDiscriptors: [ActionDescriptor<T>]) {

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
        button.action = { [weak element] in
          guard let element = element else { return }
          descriptor.action(element)
        }

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

extension _View {

  public struct ActionDescriptor<T> {

    // MARK: - Properties
    public let title: String

    public let action: (T) -> Void

    // MARK: - Initializers

    public init(title: String, action: @escaping (T) -> Void) {

      self.title = title
      self.action = action
    }
  }

}
