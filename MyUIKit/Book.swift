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
  BookFolder("A") {
    MyLabel.makeStorybookComponents()
    BookFolder("A") {
      MyLabel.makeStorybookComponents()
    }
    BookFolder("A") {
      MyLabel.makeStorybookComponents()
    }
  }
  BookFolder("A") {
    MyLabel.makeStorybookComponents()
  }
  BookFolder("A") {
    MyLabel.makeStorybookComponents()
  }
}
