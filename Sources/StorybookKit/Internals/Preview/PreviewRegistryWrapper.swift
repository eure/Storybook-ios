import DeveloperToolsSupport
import Foundation
import SwiftUI
import UIKit

@available(iOS 17.0, *)
struct PreviewRegistryWrapper: Comparable {

  let previewType: any DeveloperToolsSupport.PreviewRegistry.Type
  let module: String

  init(_ previewType: any DeveloperToolsSupport.PreviewRegistry.Type) {
    self.previewType = previewType
    self.module = previewType.fileID.components(separatedBy: "/").first!
  }

  var fileID: String { previewType.fileID }
  var line: Int { previewType.line }
  var column: Int { previewType.column }

  @MainActor
  var makeView: (@MainActor () -> any View) {
    guard let rawPreview = try? previewType.makePreview() else {
      return { EmptyView() }
    }
    let preview: FieldReader = .init(rawPreview)
    let title: String? = preview["displayName"]
    let source: FieldReader = preview["source"]
    switch source.typeName {

    case "SwiftUI.ViewPreviewSource": // iOS 17
      let makeView: MakeFunctionWrapper<any SwiftUI.View> = .init(source["makeView"])
      return {
        VStack {
          if let title, !title.isEmpty {
            Text(title)
              .font(.system(size: 17, weight: .semibold))
          }
          AnyView(makeView())
          Text("\(fileID):\(line)")
            .font(.caption.monospacedDigit())
          BookSpacer(height: 16)
        }
      }

    case "UIKit.UIViewPreviewSource": // iOS 17
      // Unsupported due to iOS 17 not supporting casting between non-sendable closure types
      return {
        VStack {
          if let title, !title.isEmpty {
            Text(title)
              .font(.system(size: 17, weight: .semibold))
          }
          Text("UIView Preview not supported on iOS 17")
            .foregroundStyle(Color.red)
            .font(.caption.monospacedDigit())
          Text("\(fileID):\(line)")
            .font(.caption.monospacedDigit())
          BookSpacer(height: 16)
        }
      }

    case "UIKit.UIViewControllerPreviewSource": // iOS 17
      // Unsupported due to iOS 17 not supporting casting between non-sendable closure types
      return {
        VStack {
          if let title, !title.isEmpty {
            Text(title)
              .font(.system(size: 17, weight: .semibold))
          }
          Text("UIViewController Preview not supported on iOS 17")
            .foregroundStyle(Color.red)
            .font(.caption.monospacedDigit())
          Text("\(fileID):\(line)")
            .font(.caption.monospacedDigit())
          BookSpacer(height: 16)
        }
      }

    case "DeveloperToolsSupport.DefaultPreviewSource<SwiftUI.ViewPreviewBody>": // iOS 18
      let makeBody: MakeFunctionWrapper<any SwiftUI.View> = .init(source["structure", "singlePreview", "makeBody"])
      return {
        VStack {
          if let title, !title.isEmpty {
            Text(title)
              .font(.system(size: 17, weight: .semibold))
          }
          AnyView(makeBody())
          Text("\(fileID):\(line)")
            .font(.caption.monospacedDigit())
          BookSpacer(height: 16)
        }
      }

    case "DeveloperToolsSupport.DefaultPreviewSource<__C.UIView>": // iOS 18
      let makeBody: MakeFunctionWrapper<UIView> = .init(source["structure", "singlePreview", "makeBody"])
      return {
        BookPreview(
          fileID,
          line,
          title: title ?? source.typeName,
          viewBlock: { _ in
            makeBody()
          }
        )
      }

    case "DeveloperToolsSupport.DefaultPreviewSource<__C.UIViewController>": // iOS 18
      let makeBody: MakeFunctionWrapper<UIViewController> = .init(source["structure", "singlePreview", "makeBody"])
      return {
        BookPresent(
          title: title ?? source.typeName,
          presentingViewControllerBlock: {
            makeBody()
          }
        )
      }

    case let sourceTypeName:
      return {
        VStack {
          if let title, !title.isEmpty {
            Text(title)
              .font(.system(size: 17, weight: .semibold))
          }
          Text("Failed to load preview (\(sourceTypeName))")
            .foregroundStyle(Color.red)
            .font(.caption.monospacedDigit())
          Text("\(fileID):\(line)")
            .font(.caption.monospacedDigit())
          BookSpacer(height: 16)
        }
      }
    }
  }


  // MARK: Comparable

  static func < (lhs: PreviewRegistryWrapper, rhs: PreviewRegistryWrapper) -> Bool {
    if lhs.module == rhs.module {
      return lhs.line < rhs.line
    }
    return lhs.module < rhs.module
  }


  // MARK: Equatable

  static func == (lhs: PreviewRegistryWrapper, rhs: PreviewRegistryWrapper) -> Bool {
    lhs.line == rhs.line && lhs.module == rhs.module
  }


  // MARK: - FieldReader

  private struct FieldReader {

    let instance: Any
    let typeName: String

    init(_ instance: Any) {
      self.instance = instance
      self.typeName = String(reflecting: type(of: instance))
      let mirror: Mirror = .init(reflecting: instance)
      self.fields = .init(
        uniqueKeysWithValues: mirror.children.compactMap { (label, value) in
          label.map({ ($0, value) })
        }
      )
    }

    subscript<T>(_ key: String, _ nextKeys: String...) -> T {
      if nextKeys.isEmpty {
        return fields[key]! as! T
      }
      else {
        return Self.traverse(from: fields[key]!, nextKeys: nextKeys) as! T
      }
    }

    subscript(_ key: String, _ nextKeys: String...) -> FieldReader {
      .init(Self.traverse(from: fields[key]!, nextKeys: nextKeys))
    }

    private let fields: [String: Any]

    private static func traverse<C: Collection<String>>(from first: Any, nextKeys: C) -> Any {
      if let key = nextKeys.first {
        let mirror: Mirror = .init(reflecting: first)
        return self.traverse(
          from: mirror.children.first(where: { $0.label == key })!.value,
          nextKeys: nextKeys.dropFirst()
        )
      }
      else {
        return first
      }
    }
  }


  // MARK: - MakeFunctionWrapper

  @MainActor
  private struct MakeFunctionWrapper<T> {

    typealias Closure = @MainActor () -> T
    private let closure: Closure

    init(_ closure: Any) {
      // TODO: We need a workaround to avoid implicit @Sendable from @MainActor closures
      self.closure = unsafeBitCast(
        closure,
        to: Closure.self
      )
    }

    func callAsFunction() -> T {
      closure()
    }
  }
}
