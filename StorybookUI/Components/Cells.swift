//
//  Cells.swift
//  StorybookUI
//
//  Created by muukii on 2020/05/16.
//  Copyright © 2020 eureka, Inc. All rights reserved.
//

import Foundation

// MARK: - SectionCell
@available(*, deprecated)
final class SectionCell : EmptyStackCell {

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
@available(*, deprecated)
final class ItemCell : HighlightStackCell {

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
