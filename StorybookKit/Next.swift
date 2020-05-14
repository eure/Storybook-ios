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

enum SyntaxCheck {

  static func run() {

    Book {
      BookSection("A") {
        BookElement {
          $0.basic()
        }

        BookElement {
          $0.basic()
        }

        BookSection("A") {
          BookElement {
            $0.basic()
          }
        }
      }
    }


    Book {
      BookSection("A") {
        BookElement {
          $0.basic()
        }

        BookElement {
          $0.basic()
        }

        BookForEach(data: [1,2,3]) { (i) in
          BookElement {
            $0.basic()
          }
        }

        BookForEach(data: [1,2,3]) { (i) in
          BookSection("\(i)") {
            BookElement {
              $0.basic()
            }
            BookElement {
              $0.basic()
            }
          }
        }
      }

      BookSection("A") {

        BookElement {
          $0.controllable()
        }

        BookSection("A") {
          BookElement {
            $0.basic()
          }

          BookSection("A") {
            BookElement {
              $0.basic()
            }
            BookElement {
              $0.basic()
            }
          }
        }
      }
    }

  }
}

import Foundation

public struct BookSection: ComponentType {

  public let title: String
  public let component: Component

  public init(_ title: String, @ComponentBuilder closure: () -> ComponentType) {
    self.title = title
    self.component = closure().asComponent()
  }

  public func asComponent() -> Component {
    .section(self)
  }
}

public protocol ElementBodyViewBuildable {
  func make() -> UIView
}

public struct ElementBodyViewBuilderRoot {
  public func basic() -> BasicElementBodyViewBuilder {
    .init()
  }

  public func controllable() -> ControllableElementBodyViewBuilder {
    .init()
  }
}

public struct BasicElementBodyViewBuilder: ElementBodyViewBuildable {
  public func make() -> UIView {
    fatalError()
  }
}

public struct ControllableElementBodyViewBuilder: ElementBodyViewBuildable {
  public func make() -> UIView {
    fatalError()
  }
}

public protocol ComponentType {

  func asComponent() -> Component
}

public struct BookElement: ComponentType {

  public let bodyViewFactory: () -> UIView

  public var title: String = ""
  public var description: String = ""
  public var backgroundColor: UIColor = .white

  public init(factory: @escaping (ElementBodyViewBuilderRoot) -> ElementBodyViewBuildable) {
    self.bodyViewFactory = factory(ElementBodyViewBuilderRoot()).make
  }

  public func asComponent() -> Component {
    .element(self)
  }
}

public struct BookForEach<Content: ComponentType>: ComponentType {

  private let components: [Content]

  public init<S: Sequence>(data: S, @ComponentBuilder make: (S.Element) -> Content) {
    let components = data.map {
      make($0)
    }
    self.components = components
  }

  public func asComponent() -> Component {
    .array(components.map { $0.asComponent() })
  }
}

extension BookElement {

  private func modified(_ modify: (inout Self) -> Void) -> Self {
    var s = self
    modify(&s)
    return s
  }

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

public struct Book {

  public let component: Component

  public init(@ComponentBuilder closure: () -> ComponentType) {
    self.component = closure().asComponent()
  }

}

public indirect enum Component: ComponentType {

  case section(BookSection)
  case element(BookElement)
  case optional(Component?)
  case array([Component])

  public func asComponent() -> Component {
    self
  }
}

@_functionBuilder
struct ComponentBuilder {

  static func buildExpression(_ element: BookElement) -> Component {
    return .element(element)
  }

  static func buildExpression(_ element: ComponentType) -> Component {
    return element.asComponent()
  }

  static func buildExpression(_ section: BookSection) -> Component {
    return .section(section)
  }

  static func buildBlock(_ component: ComponentType) -> Component {
    return component.asComponent()
  }

  static func buildBlock(_ components: ComponentType...) -> Component {
    return .array(components.map { $0.asComponent() })
  }

  static func buildBlock(_ components: [ComponentType]) -> Component {
    return .array(components.map { $0.asComponent() })
  }

  static func buildIf(_ value: Component?) -> Component {
    return .optional(value)
  }
}
