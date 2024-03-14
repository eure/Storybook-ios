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

@_exported import SwiftUI

@freestanding(declaration)
public macro StorybookPage(
  title: String,
  @ViewBuilder contents: @escaping () -> any View
) = #externalMacro(
  module: "StorybookMacrosPlugin",
  type: "StorybookPageMacro"
)

@freestanding(declaration)
public macro StorybookPage<Target>(
  target: Target.Type = Target.self,
  @ViewBuilder contents: @escaping () -> any View
) = #externalMacro(
  module: "StorybookMacrosPlugin",
  type: "StorybookPageMacro"
)

@freestanding(expression)
public macro StorybookPreview(
  title: String,
  @ViewBuilder contents: @escaping () -> any View
) -> AnyView = #externalMacro(
  module: "StorybookMacrosPlugin",
  type: "StorybookPreviewMacro"
)

@freestanding(expression)
public macro StorybookPreview<Target>(
  target: Target.Type = Target.self,
  @ViewBuilder contents: @escaping () -> any View
) -> AnyView = #externalMacro(
  module: "StorybookMacrosPlugin",
  type: "StorybookPreviewMacro"
)
