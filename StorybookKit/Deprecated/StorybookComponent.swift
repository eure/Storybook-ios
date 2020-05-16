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

import UIKit

@available(*, deprecated)
public struct StorybookComponent {
  
  public let title: String
  public let description: String
  public let bodyView: UIView
  public let backgroundColor: UIColor?
  
  public init(
    title: String,
    description: String,
    bodyView: UIView,
    backgroundColor: UIColor? = nil
  ) {
    
    self.title = title
    self.description = description
    self.bodyView = bodyView
    self.backgroundColor = backgroundColor
  }

  @available(*, deprecated, renamed: "init(title:description:bodyView:backgroundColor:)")
  public init(
    title: String,
    className: String,
    bodyView: UIView,
    backgroundColor: UIColor? = nil
  ) {

    self.title = title
    self.description = className
    self.bodyView = bodyView
    self.backgroundColor = backgroundColor
  }
}

extension StorybookComponent {
  
  public init<T>(type: T.Type, bodyView: StorybookComponentBasicView, backgroundColor: UIColor? = nil) {
    self.title = String(reflecting: T.self)
    self.description = String(reflecting: T.self)
    self.bodyView = bodyView
    self.backgroundColor = backgroundColor
  }
  
  public init(title: String? = nil, element: UIView, backgroundColor: UIColor? = nil) {
    self.title = title ?? ""
    self.description = String(reflecting: type(of: element))
    self.bodyView = StorybookComponentBasicView(element: element)
    self.backgroundColor = backgroundColor
  }
  
  public init(title: String, description: String, element: UIView, backgroundColor: UIColor? = nil) {
    self.title = title
    self.description = description
    self.bodyView = StorybookComponentBasicView(element: element)
    self.backgroundColor = backgroundColor
  }

  @available(*, deprecated, renamed: "init(title:description:element:backgroundColor:)")
  public init(title: String, className: String, element: UIView, backgroundColor: UIColor? = nil) {
    self.title = title
    self.description = className
    self.bodyView = StorybookComponentBasicView(element: element)
    self.backgroundColor = backgroundColor
  }
}

#if canImport(AsyncDisplayKit)

import AsyncDisplayKit

extension StorybookComponent {
  
  public init(title: String? = nil, viewRepresentable: ASDisplayNode) {
    self.title = title ?? ""
    self.description = String(reflecting: type(of: viewRepresentable))
    self.bodyView = StorybookComponentView(viewRepresentable: viewRepresentable)
    self.backgroundColor = nil
  }
  
}

#endif
