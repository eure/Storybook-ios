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

public struct StorybookItemDescriptor {
  
  public let title: String
  public let detail: String
  public let componentsFactory: () -> [StorybookComponent]
  public let identifier: String
  
  public init(
    title: String,
    detail: String,
    components: @escaping () -> [StorybookComponent],
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column
  ) {
    self.title = title
    self.detail = detail
    self.componentsFactory = components
    self.identifier = "\(file)|\(line)|\(column)"
  }
  
  public init(
    title: String,
    detail: String = "",
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column,
    @StorybookBuilder<StorybookComponent> _ component: @escaping () -> StorybookComponent
  ) {
    self.init(title: title,
              detail: detail,
              components: { [component()] },
              file: file,
              line: line,
              column: column)
  }
  
  public init(
    title: String,
    detail: String = "",
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column,
    @StorybookBuilder<StorybookComponent> _ components: @escaping () -> [StorybookComponent]
  ) {
    self.init(title: title,
              detail: detail,
              components: components,
              file: file,
              line: line,
              column: column)
  }
}
