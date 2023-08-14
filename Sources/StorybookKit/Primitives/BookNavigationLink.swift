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
import SwiftUI
import ResultBuilderKit

public struct DeclarationIdentifier: Hashable, Codable {

  public let index: Int

  nonisolated init() {
    index = issueUniqueNumber()
  }

  public init(raw index: Int) {
    self.index = index
  }
}

private let _lock = NSLock()
private var _counter: Int = 0
private func issueUniqueNumber() -> Int {
  _lock.lock()
  defer {
    _lock.unlock()
  }
  _counter += 1
  return _counter
}

public struct BookPageGroup: BookView, Identifiable {

  public var id: UUID = .init()

  public let title: String
  public let pages: [BookPage]

  public init(
    title: String,
    @ArrayBuilder<BookNavigationLink> pages: () -> [BookPage]
  ) {
    self.title = title
    self.pages = pages().sorted(by: { $0.title < $1.title })
  }

  public var body: some View {
    ForEach(pages) { page in
      page
    }
  }

}

/// A component that displays a disclosure view.
public struct BookNavigationLink: BookView, Identifiable {

  @Environment(\.bookContext) var context

  public var id: DeclarationIdentifier {
    declarationIdentifier
  }

  public let title: String
  public let destination: AnyView
  public let declarationIdentifier: DeclarationIdentifier

  public init<Destination: View>(
    title: String,
    @ViewBuilder destination: () -> Destination
  ) {
    self.title = title
    self.destination = AnyView(destination())
    self.declarationIdentifier = .init()
  }

  public var body: some View {

    NavigationLink {
      List {
        destination
      }
      .listStyle(.plain)
      .onAppear(perform: {
        context?.onOpen(page: self)
      })
    } label: {
      HStack {
        Image.init(systemName: "doc")
        Text(title)
      }
    }

  }
}
