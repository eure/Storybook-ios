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

import AsyncDisplayKit
import TextureBridging
import StorybookKit
import TextureSwiftSupport

public struct BookNodePreview<Node: ASDisplayNode>: BookView {

  private var backing: BookPreview<NodeView<AnyDisplayNode>>

  public var backgroundColor: UIColor {
    backing.backgroundColor
  }

  public init(
    expandsWidth: Bool = false,
    preservedHeight: CGFloat? = nil,
    nodeBlock: @escaping () -> Node
  ) {
    self.backing = .init {

      let body = nodeBlock()

      let node = AnyDisplayNode { _, size in
        if expandsWidth {
          return LayoutSpec {
            VStackLayout {
              body
                .width(size.max.width)
            }
          }
        } else {
          return LayoutSpec {
            VStackLayout { body }
          }
        }
      }

      if let preservedHeight = preservedHeight {
        node.style.height = .init(unit: .points, value: preservedHeight)
      }

      return NodeView(node: node)
    }
  }

  public var body: BookView {
    backing
      .backgroundColor(backgroundColor)
  }

  public func title(_ text: String) -> BookGroup {
    backing.title(text)
  }

  public func backgroundColor(_ color: UIColor) -> Self {
    modified {
      $0.backing = $0.backing.backgroundColor(color)
    }
  }

  public func addButton(
    _ title: String,
    handler: @escaping (Node) -> Void
  ) -> Self {
    modified {
      $0.backing = $0.backing.addButton(title) { view in
        handler(view.node.subnodes!.first as! Node)
      }
    }
  }

}
