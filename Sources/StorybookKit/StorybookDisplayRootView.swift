import SwiftUI
import SwiftUISupport
import UIKit

public struct StorybookDisplayRootView: View {

  let book: BookContainer

  @MainActor
  public init(bookStore: BookStore) {
    self.book = .init(store: bookStore)
  }
  
  @MainActor
  public init(book: any BookType) {
    self.book = .init(store: .init(book: book))
  }

  public var body: some View {

    _ViewControllerHost {
      let controller = _ViewController(book: book)
      return controller
    }
    .ignoresSafeArea()

  }
}

struct BookContainer: BookType {

  @ObservedObject var store: BookStore
  @State var isSearching: Bool = false
  @State var lastUsedItem: BookPage?

  @MainActor
  public init(
    store: BookStore
  ) {
    self.store = store
  }

  public var body: some View {

    TabView {
      NavigationView {
        List {
          Section {
            ForEach(store.historyPages) { link in
              link
            }
          } header: {
            Text("History")
          }

          Section {
            store.book
          } header: {
            Text("Contents")
          }

        }
        .navigationTitle(store.title)
      }
      .tabItem {
        Image(systemName: "list.bullet")
        Text("List")
      }

      SearchModeView(store: store)
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("Search")
        }
    }
    .environment(\.bookContext, store)
    .onAppear {
      lastUsedItem = store.historyPages.first
    }
    .sheet(item: $lastUsedItem) { item in
      ScrollView {
        item.destination
          .padding(.vertical, 24)
      }
    }
  }

  struct SearchModeView: View {

    @State var query: String = ""
    @State var result: [BookPage] = []
    @State var currentTask: Task<Void, Error>?
    let store: BookStore

    var body: some View {

      VStack {

        SearchBar(text: $query)
          .onChange(of: query) { value in
            currentTask?.cancel()
            currentTask = Task {

              let result = await store.search(query: value)

              print(result.map { $0.title })

              guard Task.isCancelled == false else {
                return
              }

              self.result = result
            }
          }
          .padding()

        NavigationView {
          List {

            ForEach(result) { page in
              page
            }

          }
        }
      }

    }
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
