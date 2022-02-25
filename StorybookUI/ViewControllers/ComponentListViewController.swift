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

import StorybookKit
import UIKit

final class ComponentListViewController: StackScrollViewController {

  enum Action {
    case onSelected(DeclarationIdentifier)
  }

  init(
    component: BookTree,
    actionHandler: @escaping (Action) -> Void
  ) {

    super.init()

    func makeCells(buffer: inout [UIView], component: BookTree) {

      switch component {
      case .folder(let v):
        buffer.append(
          FolderCell(
            title: v.title,
            didTap: { [weak self] in

              actionHandler(.onSelected(v.declarationIdentifier))

              let nextController = ComponentListViewController(
                component: v.component,
                actionHandler: actionHandler
              )
              nextController.title = v.title
              self?.showDetailViewController(nextController, sender: self)
            }
          )
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
      case .push(let push):
        buffer.append(
          PushCell(
            title: push.title,
            actionHandler: { action in
              switch action {
              case .onSelected:
                actionHandler(.onSelected(push.declarationIdentifier))
              }
            },
            pushingViewControllerBlock: push.pushingViewControllerBlock
          )
        )
      case .present(let present):
        buffer.append(
          PresentCell(
            title: present.title,
            actionHandler: { action in
              switch action {
              case .onSelected:
                actionHandler(.onSelected(present.declarationIdentifier))
              }
            },
            presentedViewControllerBlock: present.presentedViewControllerBlock
          )
        )
      case .spacer(let spacer):
        buffer.append(SpacerCell(height: spacer.height))
      case .action(let action):
        buffer.append(
          ActionCell(
            title: action.title,
            action: { viewController in
              action.action(viewController)
          })
        )
      }

    }

    var buffer = [UIView]()
    makeCells(buffer: &buffer, component: component)

    setViews(buffer)

  }

}
