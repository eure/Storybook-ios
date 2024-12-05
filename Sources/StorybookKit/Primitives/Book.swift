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

    var sortingKey: String {
      switch self {
      case .folder(let v): return v.title
      case .page(let v): return v.title
      }
    }
  }

  public var id: UUID = .init()

  public let title: String
  public let contents: [Node]

  /// All `#Preview`s as `BookPage`s
  @available(iOS 17.0, *)
  public static func allBookPreviews() -> [Node]? {
    guard let sortedPreviewRegistries = self.findAllPreviews() else {
      return nil
    }
    var fileIDsByModule: [String: Set<String>] = [:]
    var registriesByFileID: [String: [PreviewRegistryWrapper]] = [:]
    for item in sortedPreviewRegistries {
      fileIDsByModule[item.module, default: []].insert(item.fileID)
      registriesByFileID[item.fileID, default: []].append(item)
    }
    return fileIDsByModule.keys.sorted().map { module in
      return Node.folder(
        .init(
          title: module,
          contents: { [fileIDs = fileIDsByModule[module]!.sorted()] in
            fileIDs.map { fileID in
              return Node.page(
                .init(
                  fileID,
                  0,
                  title: .init(fileID[module.endIndex...]),
                  destination: { [registries = registriesByFileID[fileID]!] in
                    ScrollView {
                      LazyVStack(
                        alignment: .center,
                        spacing: 16,
                        pinnedViews: .sectionHeaders
                      ) {
                        Section(
                          content: {
                            ForEach.inefficient(items: registries) { registry in
                              AnyView(registry.makeView())
                            }
                          },
                          header: {
                            Text(fileID)
                              .truncationMode(.head)
                              .font(.caption.monospacedDigit())
                          }
                        )
                      }
                    }
                  }
                )
              )
            }
          }
        )
      )
    }
  }

  /// All conformers to `BookProvider`, including those declared from the `#StorybookPage` macro
  public static func allBookProviders() -> [any BookProvider.Type] {
    self.findAllBookProviders(filterByStorybookPageMacro: false) ?? []
  }

  /// All conformers to `BookProvider` that were declared from the `#StorybookPage` macro
  public static func allStorybookPages() -> [any BookProvider.Type] {
    self.findAllBookProviders(filterByStorybookPageMacro: true) ?? []
  }

  public init(
    title: String,
    @FolderBuilder contents: () -> [Node]
  ) {

    self.title = title

    let _contents = contents()

    let folders = _contents
      .filter {
        switch $0 {
        case .folder:
          return true
        case .page:
          return false
        }
      }
      .sorted { a, b in
        a.sortingKey < b.sortingKey
      }

    let pages = _contents
      .filter {
        switch $0 {
        case .folder:
          return false
        case .page:
          return true
        }
      }
      .sorted { a, b in
        a.sortingKey < b.sortingKey
      }

    self.contents = folders + pages

  }

  public var body: some View {
    ForEach(contents) { node in
      switch node {
      case .folder(let folder):
        NavigationLink {
          List {
            folder
          }
          .navigationTitle(folder.title)
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

  @MainActor
  public static func buildExpression<Provider: BookProvider>(_ expression: Provider.Type) -> [FolderBuilder.Element] {
    return [.page(expression.bookBody)]
  }

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
