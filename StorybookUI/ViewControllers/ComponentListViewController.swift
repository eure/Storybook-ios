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

  init(component: BookTree) {

    weak var _indirectSelf: ComponentListViewController?

    func makeCells(buffer: inout [UIView], component: BookTree) {

      switch component {
      case .folder(let v):
        buffer.append(
          FolderCell(title: v.title, didTap: {
            let nextController = ComponentListViewController(component: v.component)
            nextController.title = v.title
            _indirectSelf?.showDetailViewController(nextController, sender: _indirectSelf)
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
    super.init(views: buffer)

    _indirectSelf = self

  }

}


