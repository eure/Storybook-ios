import SwiftUI

public struct Book: BookView, Identifiable {

  public enum Node: Identifiable {

    public var id: String {
      switch self {
      case .folder(let v): return "folder.\(v.id)"
      case .page(let v): return "page.\(v.id)"
      }
    }

    case folder(Book)
    case page(BookPage)
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
      case .page(let page):
        page
      }
    }
  }

  func allPages() -> [BookPage] {
    contents.flatMap { node -> [BookPage] in
      switch node {
      case .folder(let folder):
        return folder.allPages()
      case .page(let page):
        return [page]
      }
    }
  }

}

@resultBuilder
public struct FolderBuilder {

  public typealias Element = Book.Node

  public static func buildExpression(_ expression: BookPage) -> [FolderBuilder.Element] {
    return [.page(expression)]
  }

  public static func buildExpression(_ expression: [BookPage]) -> [FolderBuilder.Element] {
    return expression.map { .page($0) }
  }

  public static func buildExpression(_ expression: Book) -> [FolderBuilder.Element] {
    return [.folder(expression)]
  }

  public static func buildExpression(_ expression: [Book]) -> [FolderBuilder.Element] {
    return expression.map { .folder($0) }
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
