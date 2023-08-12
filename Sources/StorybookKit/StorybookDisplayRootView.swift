import SwiftUI
import UIKit
import SwiftUISupport

public struct StorybookDisplayRootView<BookContent: View>: View {

  public let book: Book<BookContent>
  public let targetViewController: UIViewController

  public init(book: Book<BookContent>, targetViewController: UIViewController) {
    self.book = book
    self.targetViewController = targetViewController
  }

  public var body: some View {
    book
      .environment(\._targetViewController, targetViewController)
  }
}
