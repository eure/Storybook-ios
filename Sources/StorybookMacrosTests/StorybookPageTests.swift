//
// Copyright (c) 2024 Eureka, Inc.
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

import MacroTesting
import XCTest
import StorybookMacrosPlugin

final class StorybookPageTests: XCTestCase {

  override func invokeTest() {
    withMacroTesting(
      isRecording: false,
      macros: ["StorybookPage": StorybookPageMacro.self]
    ) {
      super.invokeTest()
    }
  }

  func testUnlabeledTitleUnlabeledContent() {
    assertMacro {
      """
      #StorybookPage<UIView> {
        VStack {
          Text("test")
        }
        .tint(.accentColor)
      }
      """
    } expansion: {
      """
      enum __macro_local_20__🤖🛠️_StorybookMagic_fMu_: BookProvider {
        @MainActor
        static var bookBody: BookPage {
          .init(
            title: _typeName(UIView.self),
            destination: {
        VStack {
          Text("test")
        }
        .tint(.accentColor)
            }
          )
        }
      }
      """
    }

    assertMacro {
      """
      #StorybookPage(title: "Path1.Path2.Title") {
        VStack {
          Text("test")
        }
        .tint(.accentColor)
      }
      """
    } expansion: {
      """
      enum __macro_local_20__🤖🛠️_StorybookMagic_fMu_: BookProvider {
       @MainActor
        static var bookBody: BookPage {
          .init(
            title: "Path1.Path2.Title",
            destination: {
        VStack {
          Text("test")
        }
        .tint(.accentColor)
            }
          )
        }
      }
      """
    }
  }

  func testLabeledTitleUnlabeledContent() {
    assertMacro {
      """
      enum Namespace1 { enum Namespace2 { enum Namespace3 { class TestableView: UIView {} } } }
      #StorybookPage(target: Namespace1.Namespace2.Namespace3.TestableView.self) {
        VStack {
          Text("test")
        }
        .tint(.accentColor)
      }
      """
    } expansion: {
      """
      enum Namespace1 { enum Namespace2 { enum Namespace3 { class TestableView: UIView {} } } }
      enum __macro_local_20__🤖🛠️_StorybookMagic_fMu_: BookProvider {
        @MainActor
        static var bookBody: BookPage {
          .init(
            title: _typeName(target: Namespace1.Namespace2.Namespace3.TestableView.self),
            destination: {
        VStack {
          Text("test")
        }
        .tint(.accentColor)
            }
          )
        }
      }
      """
    }

    assertMacro {
      """
      #StorybookPage(title: "Path1.Path2.Title") {
        VStack {
          Text("test")
        }
        .tint(.accentColor)
      }
      """
    } expansion: {
      """
      enum __macro_local_20__🤖🛠️_StorybookMagic_fMu_: BookProvider {
        @MainActor
        static var bookBody: BookPage {
          .init(
            title: "Path1.Path2.Title",
            destination: {
        VStack {
          Text("test")
        }
        .tint(.accentColor)
            }
          )
        }
      }
      """
    }
  }

  func testUnlabeledTitleLabeledContent() {
    assertMacro {
      """
      #StorybookPage<UIView>(
        contents: {
          VStack {
            Text("test")
          }
          .tint(.accentColor)
        }
      )
      """
    } expansion: {
      """
      enum __macro_local_20__🤖🛠️_StorybookMagic_fMu_: BookProvider {
        @MainActor
        static var bookBody: BookPage {
          .init(
            title: _typeName(UIView.self),
            destination: {
          VStack {
            Text("test")
          }
          .tint(.accentColor)
        }
          )
        }
      }
      """
    }

    assertMacro {
      """
      #StorybookPage(
        title: "Path1.Path2.Title",
        contents: {
          VStack {
            Text("test")
          }
          .tint(.accentColor)
        }
      )
      """
    } expansion: {
      """
      enum __macro_local_20__🤖🛠️_StorybookMagic_fMu_: BookProvider {
        @MainActor
        static var bookBody: BookPage {
          .init(
            title: "Path1.Path2.Title",
            destination: {
          VStack {
            Text("test")
          }
          .tint(.accentColor)
        }
          )
        }
      }
      """
    }
  }

  func testLabeledTitleLabeledContent() {
    assertMacro {
      """
      enum Namespace1 { enum Namespace2 { enum Namespace3 { class TestableView: UIView {} } } }
      #StorybookPage(
        target: Namespace1.Namespace2.Namespace3.TestableView.self,
        contents: {
          VStack {
            Text("test")
          }
          .tint(.accentColor)
        }
      )
      """
    } expansion: {
      """
      enum Namespace1 { enum Namespace2 { enum Namespace3 { class TestableView: UIView {} } } }
      enum __macro_local_20__🤖🛠️_StorybookMagic_fMu_: BookProvider {
        @MainActor
        static var bookBody: BookPage {
          .init(
            title: _typeName(
        target: Namespace1.Namespace2.Namespace3.TestableView.self,),
            destination: {
          VStack {
            Text("test")
          }
          .tint(.accentColor)
        }
          )
        }
      }
      """
    }

    assertMacro {
      """
      #StorybookPage(
        title: "Path1.Path2.Title",
        contents: {
          VStack {
            Text("test")
          }
          .tint(.accentColor)
        }
      )
      """
    } expansion: {
      """
      enum __macro_local_20__🤖🛠️_StorybookMagic_fMu_: BookProvider {
        @MainActor
        static var bookBody: BookPage {
          .init(
            title: "Path1.Path2.Title",
            destination: {
          VStack {
            Text("test")
          }
          .tint(.accentColor)
        }
          )
        }
      }
      """
    }
  }
}
