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

/// A structure of Book
public indirect enum BookTree: BookView {

  case folder(BookFolder)
  case element(AnyBookView)
  case optional(BookTree?)
  case array([BookTree])

  public func asTree() -> BookTree {
    self
  }
}

@_functionBuilder
public enum ComponentBuilder {

  public static func buildBlock<E: BookViewPresentableType>(_ element: E) -> BookTree {
    return .element(.init(element))
  }

  public static func buildBlock(_ component: BookView) -> BookTree {
    return component.asTree()
  }

  public static func buildBlock(_ components: BookView...) -> BookTree {
    return .array(components.map { $0.asTree() })
  }

  public static func buildBlock(_ components: [BookView]) -> BookTree {
    return .array(components.map { $0.asTree() })
  }

  public static func buildIf(_ value: BookTree?) -> BookTree {
    return .optional(value)
  }
}
