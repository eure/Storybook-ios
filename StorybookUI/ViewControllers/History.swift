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

final class HistoryManager {

  static let shared = HistoryManager()

  private let userDefaults = UserDefaults(suiteName: "jp.eure.storybook")!

  private let decoder = JSONDecoder()
  private let encoder = JSONEncoder()

  var history: History = .init()

  init() {
    loadHistory()
  }

  func updateHistory(_ update: (inout History) -> Void) {
    update(&history)
    do {
      let data = try encoder.encode(history)
      userDefaults.set(data, forKey: "history")
    } catch {
      assertionFailure("Failed to encode a history to store UserDefaults. \(error)")
    }
  }

  private func loadHistory() {
    guard let data = userDefaults.data(forKey: "history") else { return }
    do {
      let instance = try decoder.decode(History.self, from: data)
      self.history = instance
    } catch {
      assertionFailure("Failed to load a history. \(error)")
    }
  }
}

struct History: Codable {

  private var selectedLinks: [DeclarationIdentifier : Date] = [:]

  func loadSelected() -> [DeclarationIdentifier] {
    selectedLinks.sorted(by: { $0.value > $1.value }).map { $0.key }
  }

  mutating func addLink(_ identifier: DeclarationIdentifier) {
    selectedLinks[identifier] = .init()
  }
}
