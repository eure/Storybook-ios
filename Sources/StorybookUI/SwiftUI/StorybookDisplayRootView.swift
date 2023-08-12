import StorybookKit
import SwiftUI
import UIKit
import SwiftUISupport

public struct StorybookDisplayRootView: View {

  public let book: Book
  public let targetViewController: UIViewController

  public init(book: Book, targetViewController: UIViewController) {
    self.book = book
    self.targetViewController = targetViewController
  }

  public var body: some View {
    NavigationView {
      ScrollView {
        VStack {
          Text(book.title)
          BookTreeWrapper(tree: book.component)
        }
      }
      .environment(\._targetViewController, targetViewController)
    }
  }
}

enum _ViewControllerKey: EnvironmentKey {
  typealias Value = UIViewController?

  static var defaultValue: UIViewController?
}

extension EnvironmentValues {
  var _targetViewController: UIViewController? {
    get { self[_ViewControllerKey.self] }
    set { self[_ViewControllerKey.self] = newValue }
  }
}

struct BookTreeWrapper: View {

  @Environment(\._targetViewController) var targetViewController

  let tree: BookTree

  var body: some View {
    switch tree {
    case .action(let action):
      Button(action.title) {
        action.action(targetViewController!)
      }
    case .array(let trees):
      ForEach(Array(trees.enumerated()), id: \.offset) { e in
        BookTreeWrapper(tree: e.element)
      }
    case .folder(let link):
      NavigationLink(link.title, destination: {
        BookTreeWrapper(tree: link.component)
      })
    case .present(let presentation):
      Button(presentation.title) {
        let viewController = presentation.presentedViewControllerBlock()
        targetViewController?.present(viewController, animated: true)
      }
    case .push(let push):
      Button(push.title) {
        Text("push")
      }
    case .single(let bookView):
      if let tree = bookView?.asTree() {
        BookTreeWrapper(tree: tree)
      }
    case .spacer(let spacer):
      Spacer(minLength: 0)
        .frame(height: spacer.height)
    case .viewRepresentable(let representable):
      ViewHost(instantiated: representable.makeView())
    }
  }

}

#if DEBUG

enum Preview_StorybookDisplayRootView: PreviewProvider {

  static var previews: some View {

    Group {
      StorybookDisplayRootView(
        book: .init(
          title: "Hello",
          closure: {
            BookText("Hey")
          }
        ), 
        targetViewController: UIViewController()
      )
    }

  }

}

#endif
