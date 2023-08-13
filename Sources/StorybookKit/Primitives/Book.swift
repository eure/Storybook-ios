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

import ResultBuilderKit
import SwiftUI

public protocol BookProvider {
  static var body: BookNavigationLink { get }
}

public protocol BookType: View {

}

public final class BookStore: ObservableObject {

  @Published var historyPages: [BookNavigationLink] = []

  public let title: String
  public let groups: [BookPageGroup]

  private let allPages: [BookNavigationLink]

  private let userDefaults = UserDefaults(suiteName: "jp.eure.storybook2") ?? .standard

  public init(
    title: String,
    @ArrayBuilder<BookPageGroup> groups: () -> [BookPageGroup]
  ) {
    self.title = title
    self.groups = groups().sorted(by: { $0.title < $1.title })
    self.allPages = self.groups.flatMap { $0.pages }

    updateHistory()
  }

  private func updateHistory() {

    let indexes = userDefaults.array(forKey: "history") as? [Int] ?? []

    let _links = indexes.compactMap { index -> BookNavigationLink? in
      guard let page = allPages.first(where: { $0.declarationIdentifier.index == index }) else {
        return nil
      }
      return page
    }

    historyPages = _links

  }

  func onOpen(link: BookNavigationLink) {

    guard allPages.contains(where: { $0.id == link.id }) else {
      return
    }

    let index = link.declarationIdentifier.index

    var current = userDefaults.array(forKey: "history") as? [Int] ?? []
    if let index = current.firstIndex(of: index) {
      current.remove(at: index)
    }

    current.insert(index, at: 0)
    current = Array(current.prefix(5))

    userDefaults.set(current, forKey: "history")

    print("Update history", current)

    updateHistory()
  }

}

public struct BookContainer: BookType {

  @ObservedObject var store: BookStore

  @MainActor
  public init(
    store: BookStore
  ) {
    self.store = store
  }

  public var body: some View {
    NavigationView {
      List {
        Section {
          ForEach(store.historyPages) { link in
            link
          }
        } header: {
          Text("History")
        }

        ForEach(store.groups) { group in
          Section {
            group
          } header: {
            Text(group.title)
          }
        }
      }
      .listStyle(.grouped)
    }
    .navigationTitle(store.title)
    .environment(\.bookContext, store)
  }

}

public final class BookContext {

  func onOpen(link: BookNavigationLink) {
    print(link)
  }
}

private enum BookContextKey: EnvironmentKey {
  static var defaultValue: BookStore?
}

extension EnvironmentValues {

  public var bookContext: BookStore? {
    get {
      self[BookContextKey.self]
    }
    set {
      self[BookContextKey.self] = newValue
    }
  }

}
