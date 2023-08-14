import SwiftUI

public struct BookFolder: BookView, Identifiable {

  public enum Node: Identifiable {

    public var id: String {
      switch self {
      case .folder(let v): return "folder.\(v.id.uuidString)"
      case .group(let v): return "group.\(v.id.uuidString)"
      }
    }

    case folder(BookFolder)
    case group(BookPageGroup)
  }

  public var id: UUID = .init()

  public let title: String
  public let contents: [Node]

  public init(
    title: String,
    @FolderBuilder contents: () -> [Node]
  ) {

    self.title = title
    self.contents = contents()

  }

  public var body: some View {
    ForEach(contents) { node in
      switch node {
      case .folder(let folder):
        NavigationLink {
          folder
        } label: {
          HStack {
            Image.init(systemName: "folder")
            Text(folder.title)
          }
        }
      case .group(let group):
        group
      }
    }
  }

  func allPages() -> [BookPage] {
    contents.flatMap { node -> [BookPage] in
      switch node {
      case .folder(let folder):
        return folder.allPages()
      case .group(let group):
        return group.pages
      }
    }
  }

}

@resultBuilder
public struct FolderBuilder {

  public typealias Element = BookFolder.Node

  public static func buildExpression(_ expression: BookPageGroup) -> [FolderBuilder.Element] {
    return [.group(expression)]
  }

  public static func buildExpression(_ expression: BookFolder) -> [FolderBuilder.Element] {
    return [.folder(expression)]
  }

  public static func buildBlock() -> [Element] {
    []
  }

  public static func buildBlock<C: Collection>(_ contents: C...) -> [Element] where C.Element == Element {
    return contents.flatMap { $0 }
  }

  public static func buildOptional(_ component: [Element]?) -> [Element] {
    return component ?? []
  }

  public static func buildEither(first component: [Element]) -> [Element] {
    return component
  }

  public static func buildEither(second component: [Element]) -> [Element] {
    return component
  }

  public static func buildArray(_ components: [[Element]]) -> [Element] {
    components.flatMap { $0 }
  }

  public static func buildExpression(_ element: Element?) -> [Element] {
    return element.map { [$0] } ?? []
  }

  public static func buildExpression(_ element: Element) -> [Element] {
    return [element]
  }

  public static func buildExpression<C: Collection>(_ elements: C) -> [Element] where C.Element == Element {
    Array(elements)
  }

  public static func buildExpression<C: Collection>(_ elements: C) -> [Element] where C.Element == Optional<Element> {
    elements.compactMap { $0 }
  }

}
