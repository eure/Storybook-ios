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

/// A component descriptor that just displays UI-Component
public struct BookPresent: BookView {

  @Environment(\._targetViewController) private var targetViewController
  @Environment(\.test) var test

  public let declarationIdentifier: DeclarationIdentifier
  public let presentedViewControllerBlock: @MainActor () -> UIViewController

  public let title: String

  public init(
    title: String,
    presentingViewControllerBlock: @escaping @MainActor () -> UIViewController
  ) {
    self.title = title
    self.presentedViewControllerBlock = presentingViewControllerBlock
    self.declarationIdentifier = .init()
  }

  public var body: some View {
    Button(title) {
      let viewController = presentedViewControllerBlock()
      print(test)
      print(targetViewController)
      targetViewController?.present(viewController, animated: true)
    }
  }

}
