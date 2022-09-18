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

@MainActor
public let myBook = Book(title: "MyUI") {

  BookParagraph("MyBook")

  BookScope {

    let text = "Scope"

    return BookGroup {
      BookText(text)
      BookText(text)
    }
  }

  BookParagraph("This is BookText")

  BookSection(title: "Features") {

    BookNavigationLink(title: "Preview UI") {
      BookPage(title: "Typography") {

        BookHeading1("""
Here is `BookHeadline`, It allows us to describe something big picture.
""")

        BookParagraph("""
Here is `BookParagpraph`
It allows us to display multiple lines.

Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
""")

        BookParagraph("""
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
""")

        BookCallout(text: "Hello! Here is callout!")
        BookCallout(symbol: "✅", text: "Hello! Here is callout!")

        BookCallout.info(text: "Info")
        BookCallout.warning(text: "Warning")
        BookCallout.danger(text: "Danger")
        BookCallout.success(text: "Success")


        BookSection(title: "Section") {

          BookParagraph("""
Something description about this section.
""")

          BookPreview {
            let view = UIView(frame: .init(x: 0, y: 0, width: 80, height: 80))
            view.backgroundColor = .systemPurple
            NSLayoutConstraint.activate([
              view.widthAnchor.constraint(equalToConstant: 80),
              view.heightAnchor.constraint(equalToConstant: 80),
            ])
            return view
          }

          BookPreview {
            let view = UIView(frame: .init(x: 0, y: 0, width: 80, height: 80))
            view.backgroundColor = .systemPurple
            NSLayoutConstraint.activate([
              view.widthAnchor.constraint(equalToConstant: 80),
              view.heightAnchor.constraint(equalToConstant: 80),
            ])
            return view
          }
          .title("A component")

        }

        BookSection(title: "Section") { () -> BookView in

          BookPreview {
            let view = UIView(frame: .init(x: 0, y: 0, width: 80, height: 80))
            view.backgroundColor = .systemPurple
            NSLayoutConstraint.activate([
              view.widthAnchor.constraint(equalToConstant: 80),
              view.heightAnchor.constraint(equalToConstant: 80),
            ])
            return view
          }

        }

      }

    }

    BookNavigationLink(title: "AlertController") {

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

    BookNavigationLink(title: "Test Push") {
      BookPush(title: "Test") {
        UIViewController()
      }
    }

  }

  BookAlphabeticalNavigationLinkSection(title: "Examples") {

    BookNavigationLink(title: "MyLabel") {

      MyLabel.makeBookView()

      BookNavigationLink(title: "Variations") {
        BookForEach(data: [
          UIColor.systemBlue,
          UIColor.systemRed,
          UIColor.systemPink
        ]) { color in
          BookPreview {
            LightLabel.init(title: "Hello")
          }
          .backgroundColor(color)
        }
      }
    }

    BookNavigationLink(title: "LightLabel") {
      BookPreview {
        LightLabel.init(title: "Hello")
      }
      .backgroundColor(.black)
    }

  }

  labelExpandingTestBook()

  BookNavigationLink(title: "State") {
    BookPreview {
      MySuccessView()
    }
    .title("State: Success")

    BookPreview {
      MyLoadingView()
    }
    .title("State: Loading")

    BookPreview {
      MyErrorView()
    }
    .title("State: Error")
  }

  BookNavigationLink(title: "Pattern") {

    BookForEach(data: BookPattern.make(
      ["A", "AAA", "AAAAAA"],
      [UIColor.blue, UIColor.red, UIColor.orange]
    )) { (args) in
      BookPreview {
        let (text, color) = args
        let label = UILabel()
        label.text = text
        label.textColor = color
        return label
      }
    }

  }
  
}

@MainActor
fileprivate func labelExpandingTestBook() -> BookView {

  BookSection(title: "UILabel updating text") {
    BookPreview<UILabel> {
      let label = UILabel()
      label.text = ""
      return label
    }
    .addButton("empty") { (label) in
      label.text = ""
    }
    .addButton("short text") { (label) in
      label.text = "Hello"
    }
    .addButton("long text") { (label) in
      label.text = "Hello, Hello,"
    }
  }

}

extension MyLabel {

  fileprivate static func makeBookView() -> BookView {
    BookGroup {
      BookPreview {
        self.init(title: "Hello")
      }
      .backgroundColor(.orange)
      .title("Short Text")

      BookPreview {
        self.init(title: "HelloHelloHelloHello")
      }
      .title("Long Text")

      BookPreview {
        self.init(title: "HelloHelloHelloHello")
      }
      .addButton("Delete") { (label) in
        label.label.text = ""
      }
    }
  }

  fileprivate static func makeBookView_1() -> BookView {
    BookPreview {
      self.init(title: "")
    }
  }

  fileprivate static func makeBookView_2() -> BookView {
    BookGroup {
      BookPreview {
        self.init(title: "")
      }
      BookPreview {
        self.init(title: "")
      }
    }
  }

  fileprivate static func makeBookView_3() -> BookView {
    BookGroup {
      BookPreview {
        self.init(title: "")
      }
      BookPreview {
        self.init(title: "")
      }
      BookNavigationLink(title: "Nested") {
        BookPreview {
          self.init(title: "")
        }
        BookNavigationLink(title: "Nested") {
          BookPreview {
            self.init(title: "")
          }
          BookPreview {
            self.init(title: "")
          }
          BookNavigationLink(title: "Nested") {
            BookPreview {
              self.init(title: "")
            }
          }
        }
      }
    }
  }
}
