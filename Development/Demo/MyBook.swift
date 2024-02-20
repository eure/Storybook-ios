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

import Foundation
import StorybookKit
import SwiftUISupport

@MainActor
let myBook2 = Book.init(
  title: "MyUI",
  contents: {

    Book(title: "A") {
      BookPage(title: "Preview UI") {
        BookSection(title: "Section") {

          Text(
              """
              Something description about this section.
              """
          )

          BookPreview { _ in
            let view = UIView(frame: .init(x: 0, y: 0, width: 80, height: 80))
            view.backgroundColor = .systemPurple
            NSLayoutConstraint.activate([
              view.widthAnchor.constraint(equalToConstant: 80),
              view.heightAnchor.constraint(equalToConstant: 80),
            ])
            return view
          }

          BookPreview(title: "A component") { _ in
            let view = UIView(frame: .null)
            view.backgroundColor = .systemPurple
            return view
          }
          .previewFrame(width: 80, height: 80)

          BookPreview { _ in
            let view = UIView(frame: .init(x: 0, y: 0, width: 80, height: 80))
            view.backgroundColor = .systemPurple
            return view
          }
          .previewFrame(maxWidth: .greatestFiniteMagnitude, idealHeight: 10)

        }

      }
      BookPage(title: "AlertController") {

        BookPresent(title: "Pop") {
          let alert = UIAlertController(
            title: "Hi Storybook",
            message: "As like this, you can present any view controller to check the behavior.",
            preferredStyle: .alert
          )
          alert.addAction(.init(title: "Got it", style: .default, handler: { _ in }))
          return alert
        }

        BookPresent(title: "Another Pop") {
          let alert = UIAlertController(
            title: "Hi Storybook",
            message: "As like this, you can present any view controller to check the behavior.",
            preferredStyle: .alert
          )
          alert.addAction(.init(title: "Got it", style: .default, handler: { _ in }))
          return alert
        }

      }

      BookPage(title: "Test Push") {
        BookPush(title: "Test") {
          UIViewController()
        }
      }

      BookPage(title: "State") {
        BookPreview(title: "State: Success") { _ in
          MySuccessView()
        }

        BookPreview(title: "State: Loading") { _ in
          MyLoadingView()
        }

        BookPreview(title: "State: Error") { _ in
          MyErrorView()
        }
      }

      BookPage(title: "Pattern") {

        BookPattern.make(
          ["A", "AAA", "AAAAAA"],
          [UIColor.blue, UIColor.red, UIColor.orange]
        )
        .makeBody { args in
          BookPreview { _ in
            let (text, color) = args
            let label = UILabel()
            label.text = text
            label.textColor = color
            return label
          }
        }

      }

      Book(title: "B") {
      }

    }

  }
)

#StorybookPage(title: "UILabel updating text") {
  BookPreview { context in
    let label = UILabel()
    label.text = "Test"

    context.control {
      HStack {
        Button("Empty") {
          label.text = ""
        }
        Button("Short") {
          label.text = "Hello"
        }
        Button("Long Text") {
          label.text = "Hello, Hello,"
        }
      }
    }

    return label
  }
}


#StorybookPage<MyLabel> {
  BookPreview(title: "Short Text") { _ in
    MyLabel(title: "Hello")
  }
  .previewFrame(width: nil, height: 100)

  BookPreview(title: "Long Text") { _ in
    MyLabel(title: "HelloHelloHelloHello")
  }
  .previewFrame(width: nil, height: 100)

  BookPreview { context in
    let view = MyLabel(title: "HelloHelloHelloHello")

    context.control {
      Button("Delete") {
        view.label.text = ""
      }
    }

    return view
  }
  .previewFrame(width: nil, height: 100)
}

#StorybookPage<MyLabel> {
  BookPreview { _ in
    MyLabel(title: "Test")
  }
}

#StorybookPage<MyLabel> {
  BookPreview { _ in
    MyLabel(title: "Test")
  }
  BookPreview { _ in
    MyLabel(title: "Test")
  }
}

#StorybookPage<MyLabel> {
  BookPreview { _ in
    MyLabel(title: "Test")
  }
  BookPreview { _ in
    MyLabel(title: "Test")
  }
  BookPage(title: "Nested") {
    BookPreview { _ in
      MyLabel(title: "Test")
    }
    BookPage(title: "Nested") {
      BookPreview { _ in
        MyLabel(title: "Test")
      }
      BookPreview { _ in
        MyLabel(title: "Test")
      }
      BookPage(title: "Nested") {
        BookPreview { _ in
          MyLabel(title: "Test")
        }
      }
    }
  }
}
