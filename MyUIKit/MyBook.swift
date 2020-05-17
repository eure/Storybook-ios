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
  
}

extension MyLabel {

  fileprivate static func makeBookView() -> _BookView {
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
}
