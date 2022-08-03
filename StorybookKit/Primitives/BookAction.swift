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
import UIKit

public struct BookAction: BookView {
  
  public let declarationIdentifier: DeclarationIdentifier
  
  public let action: @MainActor (UIViewController) -> Void

  public let title: String

  public var body: BookView {
    fatalError()
  }

  public init(
    _ file: StaticString = #file,
    _ line: UInt = #line,
    _ column: UInt = #column,
    title: String,
    action: @escaping @MainActor (UIViewController) -> Void
  ) {
    self.title = title
    self.action = action
    self.declarationIdentifier = .init(
      file: file.description,
      line: line,
      column: column,
      typeName: _typeName(type(of: self))
    )
  }

  public func asTree() -> BookTree {
    return .action(self)
  }
  
}
