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

import SwiftUI

private struct FrameConstraint {
  var minWidth: CGFloat? = nil
  var idealWidth: CGFloat? = nil
  var maxWidth: CGFloat? = nil
  var minHeight: CGFloat? = nil
  var idealHeight: CGFloat? = nil
  var maxHeight: CGFloat? = nil
}

public struct BookPreview<PlatformView: UIView>: BookView {

  public struct Context {

    var controlView: AnyView?

    public mutating func control<Content: View>(_ content: () -> Content) {
      controlView = AnyView(content())
    }

  }

  public let viewBlock: @MainActor (inout Context) -> PlatformView

  public let declarationIdentifier: DeclarationIdentifier

  private let file: StaticString
  private let line: UInt
  private let title: String?
  private var frameConstraint: FrameConstraint = .init()

  public init(
    _ file: StaticString = #file,
    _ line: UInt = #line,
    title: String? = nil,
    viewBlock: @escaping @MainActor (inout Context) -> PlatformView
  ) {

    self.title = title
    self.file = file
    self.line = line
    self.viewBlock = viewBlock

    self.declarationIdentifier = .init()
  }

  @State var controlView: AnyView?

  public var body: some View {

    Group {
      VStack {
        if let title {
          Text(title)
            .font(.system(size: 17, weight: .semibold))
        }
        _ViewHost(
          instantiate: {

            var context: Context = .init()
            let view = viewBlock(&context)

            // TODO: currently using workaround
            Task {
              controlView = context.controlView
            }

            return _View(element: view, frameConstraint: frameConstraint)
          },
          update: { _, _ in }
        )

        controlView
      }

      Text("\(file.description):\(line.description)")
        .font(.body.monospacedDigit())

      BookSpacer(height: 16)
    }

  }

  public func previewFrame(
    width: CGFloat?,
    height: CGFloat?
  ) -> Self {
    modified {
      $0.frameConstraint.idealWidth = width
      $0.frameConstraint.idealHeight = height
    }
  }

  public func previewFrame(
    minWidth: CGFloat? = nil,
    idealWidth: CGFloat? = nil,
    maxWidth: CGFloat? = nil,
    minHeight: CGFloat? = nil,
    idealHeight: CGFloat? = nil,
    maxHeight: CGFloat? = nil
  ) -> Self {
    modified {
      $0.frameConstraint.minWidth = minWidth
      $0.frameConstraint.maxWidth = maxWidth
      $0.frameConstraint.minHeight = minHeight
      $0.frameConstraint.maxHeight = maxHeight

      $0.frameConstraint.idealWidth = idealWidth
      $0.frameConstraint.idealHeight = idealHeight
    }
  }

}

private final class _View: UIView {

  override class var requiresConstraintBasedLayout: Bool { true }

  init() {
    super.init(frame: .zero)

  }

  @available(*, unavailable)
  required init?(
    coder aDecoder: NSCoder
  ) {
    fatalError("init(coder:) has not been implemented")
  }

  convenience init(
    element: UIView,
    frameConstraint: FrameConstraint
  ) {

    self.init()

    element.translatesAutoresizingMaskIntoConstraints = false
    element.setContentHuggingPriority(.defaultLow, for: .horizontal)
    element.setContentHuggingPriority(.defaultLow, for: .vertical)

    addSubview(element)

    var constraints: [NSLayoutConstraint] = []

    if let maxWidth = frameConstraint.maxWidth {
      if (maxWidth == .infinity) || (maxWidth == .greatestFiniteMagnitude) {
        let c = element.widthAnchor.constraint(equalToConstant: 5000)
        c.priority = .defaultHigh + 1
        constraints.append(
          c
        )
      } else {
        constraints.append(
          element.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth)
        )
      }
    }

    if let maxHeight = frameConstraint.minHeight {

      if (maxHeight == .infinity) || (maxHeight == .greatestFiniteMagnitude) {
        let c = element.heightAnchor.constraint(equalToConstant: 5000)
        c.priority = .defaultHigh + 1
        constraints.append(
          c
        )
      } else {

        constraints.append(
          element.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight)
        )
      }
    }

    if let minWidth = frameConstraint.minWidth {
      constraints.append(
        element.widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth)
      )
    }

    if let minHeight = frameConstraint.minHeight {

      constraints.append(
        element.heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight)
      )
    }

    if let idealWidth = frameConstraint.idealWidth {
      constraints.append(
        element.widthAnchor.constraint(equalToConstant: idealWidth)
      )
    }

    if let idealHeight = frameConstraint.idealHeight {
      constraints.append(
        element.heightAnchor.constraint(equalToConstant: idealHeight)
      )
    }

    constraints.append(contentsOf: [

      element.centerXAnchor.constraint(equalTo: centerXAnchor),
      element.centerYAnchor.constraint(equalTo: centerYAnchor),

      element.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
      element.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor),
      element.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor),
      element.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),

    ])

    NSLayoutConstraint.activate(constraints)

  }

}
