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
public struct BookDisplay: BookViewType, BookElementType {

  public let viewBlock: () -> UIView

  public var title: String = ""
  public var description: String = ""
  public var backgroundColor: UIColor = .white

  public init(viewBlock: @escaping () -> UIView) {
    self.viewBlock = viewBlock
  }

  public func asTree() -> BookTree {
    .element(AnyBookElement(self))
  }

  public func makeView() -> UIView {
    StorybookComponentBasicView(stretchableElement: viewBlock())
  }
}

/// A component descriptor that can control a UI-Component with specified button.
public struct BookInteractive<View: UIView>: BookViewType, BookElementType {

  public let viewBlock: () -> View

  public var title: String = ""
  public var description: String = ""
  public var backgroundColor: UIColor = .white

  private var buttons: ContiguousArray<(title: String, handler: (View) -> Void)> = .init()

  public init(viewBlock: @escaping () -> View) {
    self.viewBlock = viewBlock
  }

  public func asTree() -> BookTree {
    .element(AnyBookElement(self))
  }

  public func addButton(_ title: String, handler: @escaping (View) -> Void) -> Self {
    modified {
      $0.buttons.append((title: title, handler: handler))
    }
  }

  public func makeView() -> UIView {
    StorybookComponentInteractiveView(
      element: viewBlock(),
      actionDiscriptors: buttons.map {
        StorybookComponentInteractiveView.ActionDescriptor(title: $0.title, action: $0.handler)
    })
  }
}

/// A component descriptor that just displays UI-Component
public struct BookPresent: BookViewType, BookElementType {

  public let presentedViewControllerBlock: () -> UIViewController

  public var title: String = ""
  public var description: String = ""
  public var backgroundColor: UIColor = .white

  public init(
    title: String,
    presentingViewControllerBlock: @escaping () -> UIViewController
  ) {
    self.presentedViewControllerBlock = presentingViewControllerBlock
  }

  public func asTree() -> BookTree {
    .element(AnyBookElement(self))
  }

  public func makeView() -> UIView {
    StorybookComponentPresentableView(title: title, presentedViewControllerBlock: presentedViewControllerBlock)
  }
}

