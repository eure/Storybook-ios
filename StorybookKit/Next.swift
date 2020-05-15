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

public struct Book {

  public let component: BookTree

  public init(@ComponentBuilder closure: () -> BookViewType) {
    self.component = closure().asTree()
  }

}


public protocol BookViewType {

  func asTree() -> BookTree
}

extension BookViewType {

  func modified(_ modify: (inout Self) -> Void) -> Self {
    var s = self
    modify(&s)
    return s
  }

}

public protocol BookElementType: BookViewType {
  var title: String { get set }
  var description: String { get set }
  var backgroundColor: UIColor { get set }

  func makeView() -> UIView
}

extension BookElementType {
  public func title(_ title: String) -> Self {
    modified {
      $0.title = title
    }
  }

  public func description(_ description: String) -> Self {
    modified {
      $0.description = description
    }
  }

  public func backgroundColor(_ color: UIColor) -> Self {
    modified {
      $0.backgroundColor = color
    }
  }
}

public struct AnyBookElement: BookViewType, BookElementType {

  public var title: String

  public var description: String

  public var backgroundColor: UIColor

  private let _makeView: () -> UIView

  public init<E: BookElementType>(_ element: E) {

    self.title = element.title
    self.description = element.description
    self.backgroundColor = element.backgroundColor
    self._makeView = element.makeView
  }

  public func asTree() -> BookTree {
    return .element(self)
  }

  public func makeView() -> UIView {
    _makeView()
  }
}
