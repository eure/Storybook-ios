import SwiftUI

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
