//
//  Book.swift
//  MyUIKit
//
//  Created by muukii on 2020/05/16.
//  Copyright © 2020 eureka, Inc. All rights reserved.
//

import Foundation

import StorybookKit

public let myBook = Book {

  BookText("MyBook")

  BookText("This is BookText")

  BookForEach(data: 0..<3) { (i) in
    BookText("Repeats with BookForEatch \(i)")
  }

  BookNavigationLink(title: "MyLabel") {

    MyLabel.makeBookView()

    BookNavigationLink(title: "Variations") {
      BookForEach(data: [
        UIColor.systemBlue,
        UIColor.systemRed,
        UIColor.systemPink
      ]) { color in
        BookDisplay {
          LightLabel.init(title: "Hello")
        }
        .backgroundColor(color)
      }
    }
  }

  BookNavigationLink(title: "LightLabel") {
    BookDisplay {
      LightLabel.init(title: "Hello")
    }
    .backgroundColor(.black)
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

  BookNavigationLink(title: "Typography") {
    BookPage(title: "Typography") {

      BookHeadline("""
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

      BookSection(title: "Section") {

        BookParagraph("""
Something description about this section.
""")

        BookDisplay {
          let view = UIView(frame: .init(x: 0, y: 0, width: 80, height: 80))
          view.backgroundColor = .systemPurple
          NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 80),
            view.heightAnchor.constraint(equalToConstant: 80),
          ])
          return view
        }

        BookDisplay {
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

        BookDisplay {
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
  
}

extension MyLabel {


  fileprivate static func makeBookView() -> BookView {
    BookGroup {
      BookDisplay {
        self.init(title: "Hello")
      }
      .backgroundColor(.orange)
      .title("Short Text")

      BookDisplay {
        self.init(title: "HelloHelloHelloHello")
      }
      .title("Long Text")

      BookDisplay {
        self.init(title: "HelloHelloHelloHello")
      }
      .addButton("Delete") { (label) in
        label.label.text = ""
      }
    }
  }

  fileprivate static func makeBookView_1() -> BookView {
    BookDisplay {
      self.init(title: "")
    }
  }

  fileprivate static func makeBookView_2() -> BookView {
    BookGroup {
      BookDisplay {
        self.init(title: "")
      }
      BookDisplay {
        self.init(title: "")
      }
    }
  }

  fileprivate static func makeBookView_3() -> BookView {
    BookGroup {
      BookDisplay {
        self.init(title: "")
      }
      BookDisplay {
        self.init(title: "")
      }
      BookFolder("Nested") {
        BookDisplay {
          self.init(title: "")
        }
        BookFolder("Nested") {
          BookDisplay {
            self.init(title: "")
          }
          BookDisplay {
            self.init(title: "")
          }
          BookFolder("Nested") {
            BookDisplay {
              self.init(title: "")
            }
          }
        }
      }
    }
  }
}
