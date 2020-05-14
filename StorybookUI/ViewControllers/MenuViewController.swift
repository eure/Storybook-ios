//
// Copyright (c) 2020 Eureka, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

import StorybookKit

// MARK: - MenuViewController
final class MenuViewController : CodeBasedViewController {
  
  struct Identifier : Equatable {
    
    let raw: String
    
    init(menu: StorybookMenuDescriptor,
         section: StorybookSectionDescriptor,
         item: StorybookItemDescriptor) {
      self.raw = "\(menu.identifier)|\(section.identifier)|\(item.identifier)"
    }
    
    init(raw: String) {
      self.raw = raw
    }
  }
  
  private let defaults = UserDefaults.init(suiteName: "jp.eure.storybook")
  
  private let stackScrollView = StackScrollView()
  
  private let menuDescriptor: StorybookMenuDescriptor
  
  init(menuDescriptor: StorybookMenuDescriptor) {
    
    self.menuDescriptor = menuDescriptor
    
    super.init()
    
    title = "Storybook"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if #available(iOS 13.0, *) {
      view.backgroundColor = .systemBackground
    } else {
      view.backgroundColor = .white
    }
    
    stackScrollView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(stackScrollView)
    
    NSLayoutConstraint.activate([
      stackScrollView.topAnchor.constraint(equalTo: view.topAnchor),
      stackScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      stackScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    do {
      
      let lastSelectedItemIdentifier = loadLastSelectedItemIdentifier()
      var lastSelectedItemViews: [UIView]?
      
      let views: [UIView] = menuDescriptor.sections.flatMap { section in
        return makeSectionTitleViews(title: section.title) +
          section.items.flatMap { item -> [UIView] in
            
            let identifier = Identifier(menu: menuDescriptor,
                                        section: section,
                                        item: item)
            
            if identifier == lastSelectedItemIdentifier {
              lastSelectedItemViews = self.makeItemViews(
                for: item,
                identifier: identifier
              )
            }
            
            return self.makeItemViews(for: item, identifier: identifier)
        }
      }
      
      if let itemViews = lastSelectedItemViews {
        stackScrollView.append(
          views: makeSectionTitleViews(title: "Last selected item") + itemViews
        )
      }
      
      stackScrollView.append(views: views)
    }
    
  }
  
  private func storeLastSelectItem(identifier: Identifier) {
    
    defaults?.setValue(identifier.raw, forKey: "lastSelectedItem")
    
  }
  
  private func loadLastSelectedItemIdentifier() -> Identifier? {
    
    let string = defaults?.value(forKey: "lastSelectedItem") as? String
    
    return string.map { Identifier(raw: $0) }
  }
  
  private func makeSectionTitleViews(title: String) -> [UIView] {
    return [
      SectionCell(title: title),
      SeparatorView(leftMargin: 32)
    ]
  }
  
  private func makeItemViews(for descriptor: StorybookItemDescriptor,
                             identifier: Identifier) -> [UIView] {
    return [
      ItemCell(title: descriptor.title) { [weak self] in
        self?.showDetailViewController(
          StackScrollViewController(descriptor: descriptor),
          sender: self
        )
        self?.storeLastSelectItem(identifier: identifier)
      },
      SeparatorView(leftMargin: 32)
    ]
  }
}

// MARK: - SectionCell
final private class SectionCell : EmptyStackCell {
  
  // MARK: - Properties
  
  private let titleLabel = UILabel()
  
  // MARK: - Initializers
  
  init(title: String) {
    
    super.init()
    
    titleLabel.numberOfLines = 0
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16.0),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0)
    ])
    
    set(title: title)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Functions
  
  func set(title: String) {
    titleLabel.text = title
  }
  
}

// MARK: - ItemCell
final private class ItemCell : HighlightStackCell {
  
  // MARK: Properties
  
  private let titleLabel = UILabel()
  
  private let didTapAction: () -> Void
  
  // MARK: - Initializers
  
  init(title: String, didTap: @escaping () -> Void = {}) {
    
    self.didTapAction = didTap
    super.init()
    
    addTarget(self, action: #selector(_didTap), for: .touchUpInside)
    
    
    titleLabel.numberOfLines = 0
    titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32.0),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
      titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16.0)
    ])
    
    set(title: title)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Functions
  
  func set(title: String) {
    titleLabel.text = title
  }
  
  @objc private dynamic func _didTap() {
    didTapAction()
  }
  
}
