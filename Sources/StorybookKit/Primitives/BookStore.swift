

public final class BookStore: ObservableObject {

  @Published var historyPages: [BookNavigationLink] = []

  public let title: String
  public let folders: [BookFolder]

  private let allPages: [BookNavigationLink.ID: BookNavigationLink]

  private let userDefaults = UserDefaults(suiteName: "jp.eure.storybook2") ?? .standard

  public init(
    book: Book
  ) {

    self.title = book.title

    self.folders = book.folders

    self.allPages = book.folders.flatMap {
      $0.contents.flatMap {
        switch $0 {
        case .folder(let v): return v.allPages()
        case .group(let v): return v.pages
        }
      }
    }
    .reduce(
      into: [BookNavigationLink.ID: BookNavigationLink](),
      { partialResult, item in
        partialResult[item.id] = item
      }
    )

    updateHistory()
  }

  private func updateHistory() {

    let indexes = userDefaults.array(forKey: "history") as? [Int] ?? []

    let _pages = indexes.compactMap { index -> BookPage? in
      guard let page = allPages[.init(raw: index)] else {
        return nil
      }
      return page
    }

    historyPages = _pages

  }

  func onOpen(page: BookPage) {

    guard allPages.keys.contains(page.id) else {
      return
    }

    let index = page.declarationIdentifier.index

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
