import SwiftUI

public enum _ViewControllerKey: EnvironmentKey {
  public static var defaultValue: UIViewController?
}

enum TestKey: EnvironmentKey {
  static var defaultValue: String { "default" }
}


extension EnvironmentValues {
  var _targetViewController: UIViewController? {
    get { self[_ViewControllerKey.self] }
    set { self[_ViewControllerKey.self] = newValue }
  }

  var test: String {
    get { self[TestKey.self] }
    set { self[TestKey.self] = newValue }
  }
}
