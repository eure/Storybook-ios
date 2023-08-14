import SwiftUI
import SwiftUISupport
import UIKit

public struct StorybookDisplayRootView: View {

  let book: BookContainer

  @MainActor
  public init(bookStore: BookStore) {
    self.book = .init(store: bookStore)
  }

  public var body: some View {

    _ViewControllerHost {
      let controller = _ViewController(book: book)
      return controller
    }

  }
}

struct BookContainer: BookType {

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

        ForEach(store.folders) { folder in
          Section {
            folder
          } header: {
            Text("Contents")
          }
        }
      }
      .listStyle(.grouped)
    }
    .navigationTitle(store.title)
    .environment(\.bookContext, store)
  }

}

final class _ViewController<Book: BookType>: UIViewController {

  private let book: Book

  init(book: Book) {
    self.book = book
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let hosting = UIHostingController(
      rootView:
        book
        .environment(\._targetViewController, self)
    )

    addChild(hosting)
    view.addSubview(hosting.view)
    hosting.view.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      hosting.view.topAnchor.constraint(equalTo: view.topAnchor),
      hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])

    hosting.didMove(toParent: self)

  }

}
