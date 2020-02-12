//
//  FunctionBuilder.swift
//  StorybookKit
//
//  Created by Yuka Kobayashi on 2020/01/28.
//  Copyright © 2020 eureka, Inc. All rights reserved.
//

import Foundation

@_functionBuilder public struct StorybookBuilder<T> {

  public static func buildBlock(_ contents: T...) -> [T] {
    return contents
  }
  
  public static func buildBlock(_ contents: [T]...) -> [T] {
    return contents.reduce(into: []) { $0 += $1 }
  }
}
