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
import UIKit

public final class MyComponent: UIView {

  public override func layoutSubviews() {
    super.layoutSubviews()

    backgroundColor = .systemPurple
  }

  public override var intrinsicContentSize: CGSize {
    .init(width: 60, height: 60)
  }
}

final class MySuccessView: UIView {

  private let label: UILabel = .init()

  init() {
    super.init(frame: .zero)
    backgroundColor = .systemTeal
    label.text = "Success"
    label.font = .systemFont(ofSize: 22, weight: .bold)
    label.textColor = .white

    label.translatesAutoresizingMaskIntoConstraints = false
    addSubview(label)

    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0)
    ])

  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

final class MyLoadingView: UIView {

  private let label: UILabel = .init()

  init() {
    super.init(frame: .zero)
    backgroundColor = .systemGray
    label.text = "Loading"
    label.font = .systemFont(ofSize: 22, weight: .bold)
    label.textColor = .white

    label.translatesAutoresizingMaskIntoConstraints = false
    addSubview(label)

    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0)
    ])

  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

final class MyErrorView: UIView {

  private let label: UILabel = .init()

  init() {
    super.init(frame: .zero)
    backgroundColor = .systemRed
    label.text = "Error"
    label.font = .systemFont(ofSize: 22, weight: .bold)
    label.textColor = .white

    label.translatesAutoresizingMaskIntoConstraints = false
    addSubview(label)

    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0)
    ])

  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
