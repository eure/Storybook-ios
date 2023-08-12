import SwiftUI

struct _ViewHost<ContentView: UIView>:
  UIViewRepresentable
{

  private let instantiate: @MainActor () -> ContentView
  private let _update:
  @MainActor (_ uiView: ContentView, _ context: Context) -> Void

  init(
    instantiate: @escaping @MainActor () -> ContentView,
    update: @escaping @MainActor (_ uiViewController: ContentView, _ context: Context) ->
    Void = { _, _ in }
  ) {
    self.instantiate = instantiate
    self._update = update
  }

  func makeUIView(context: Context) -> ContentView {
    let instantiated = instantiate()
    return instantiated
  }

  func updateUIView(_ uiView: ContentView, context: Context) {
    _update(uiView, context)
  }

}
