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

import AsyncDisplayKit
import SwiftUI
import StorybookKit
import TextureBridging
import TextureSwiftSupport

public struct BookNodePreview: BookView {

  private var backing: BookPreview

  public init(
    _ file: String = #fileID,
    _ line: Int = #line,
    title: String? = nil,
    nodeBlock: @escaping @MainActor (inout BookPreview.Context) -> ASDisplayNode
  ) {
    
    self.backing = .init(file, line, title: title) { context in
      let body = nodeBlock(&context)

      let node = AnyDisplayNode { _, size in
        return LayoutSpec {
          VStackLayout { body.flexGrow(1).flexShrink(1) }
        }
      }
      return NodeView(node: node)
    }
    
  }

  public var body: some View {
    backing
  }

  public func previewFrame(
    width: CGFloat?,
    height: CGFloat?
  ) -> Self {
    modified {
      $0.backing = $0.backing.previewFrame(width: width, height: height)
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
      $0.backing = $0.backing.previewFrame(
        minWidth: minWidth,
        idealWidth: idealWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        idealHeight: idealHeight,
        maxHeight: maxHeight
      )
    }
  }

}
