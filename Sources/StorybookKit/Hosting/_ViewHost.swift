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

  func makeUIView(context: Context) -> _Label<ContentView> {
    let instantiated = instantiate()
    return .init(contentView: instantiated)
  }

  func updateUIView(_ uiView: _Label<ContentView>, context: Context) {
    _update(uiView.contentView, context)
  }

}

final class _Label<ContentView: UIView>: UILabel {

  let contentView: ContentView

  init(contentView: ContentView) {
    self.contentView = contentView
    super.init(frame: .null)
    addSubview(contentView)
    numberOfLines = 0
    isUserInteractionEnabled = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {

    var targetSize = bounds.size

    if targetSize.width == CGFloat(Float.greatestFiniteMagnitude) {
      targetSize.width = UIView.layoutFittingCompressedSize.width
    }

    if targetSize.height == CGFloat(Float.greatestFiniteMagnitude) {
      targetSize.height = UIView.layoutFittingCompressedSize.height
    }

    let size = contentView.systemLayoutSizeFitting(targetSize)
    return .init(origin: .zero, size: size)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    contentView.frame = bounds
  }

}
