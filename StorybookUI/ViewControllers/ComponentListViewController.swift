//
//  ComponentListViewController.swift
//  StorybookUI
//
//  Created by muukii on 2020/05/16.
//  Copyright © 2020 eureka, Inc. All rights reserved.
//

import Foundation
import StorybookKit

final class ComponentListViewController: StackScrollViewController {

  var onSelectedLink: (BookNavigationLink) -> Void = { _ in }

  init(component: BookTree, onSelectedLink: @escaping (BookNavigationLink) -> Void) {

    super.init()

    func makeCells(buffer: inout [UIView], component: BookTree) {

      switch component {
      case .folder(let v):
        buffer.append(
          FolderCell(title: v.title, didTap: { [weak self] in

            onSelectedLink(v)

            let nextController = ComponentListViewController(
              component: v.component,
              onSelectedLink: onSelectedLink
            )
            nextController.title = v.title
            self?.showDetailViewController(nextController, sender: self)
          })
        )
      case .single(let v):
        if let v = v {
          makeCells(buffer: &buffer, component: v.asTree())
        }
      case .viewRepresentable(let v):
        buffer.append(
          v.makeView()
        )
      case .array(let v):
        v.forEach {
          makeCells(buffer: &buffer, component: $0)
        }
      }

    }

    var buffer = [UIView]()
    makeCells(buffer: &buffer, component: component)

    setViews(buffer)

  }

}


