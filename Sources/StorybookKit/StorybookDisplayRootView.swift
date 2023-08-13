import SwiftUI
import SwiftUISupport
import UIKit

public struct StorybookDisplayRootView<Book: BookType>: View {

  public let book: Book

  public init(book: Book) {
    self.book = book
  }

  public var body: some View {

    _ViewControllerHost {
      let controller = _ViewController(book: book)
      return controller
    }

  }
}

public struct StorybookDisplayRootView2: View {

  public let book: BookContainer

  public init(book: BookContainer) {
    self.book = book
  }

  public var body: some View {

    _ViewControllerHost {
      let controller = _ViewController(book: book)
      return controller
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
