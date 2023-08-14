

public final class BookStore: ObservableObject {

  @Published var historyPages: [BookPage] = []

  public let title: String
  public let book: Book

  private let allPages: [BookPage.ID: BookPage]

  private let userDefaults = UserDefaults(suiteName: "jp.eure.storybook2") ?? .standard

  public init(
    book: Book
  ) {

    self.title = book.title
    self.book = book

    self.allPages = book.allPages().reduce(
      into: [BookPage.ID: BookPage](),
      { partialResult, item in
        partialResult[item.id] = item
      }
    )

    updateHistory()
  }

  private func updateHistory() {

    let indexes = userDefaults.array(forKey: "history") as? [Int] ?? []

    let _pages = indexes.compactMap { (index: Int) -> BookPage? in
      let id = DeclarationIdentifier(raw: index)
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
