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

import Foundation
import MachO

extension Book {

  // MARK: Internal

  /// Should match `StorybookPageMacro._magicSubstring`
  static let _magicSubstring: String = "__🤖🛠️_StorybookMagic_"

  static func findAllBookProviders(
    filterByStorybookPageMacro: Bool = false
  ) -> [any BookProvider.Type]? {
    let moduleName = Bundle.main.bundleURL.deletingPathExtension().lastPathComponent
    guard !moduleName.isEmpty else {
      return nil
    }
    let allImageNames: [String?] = (0..<_dyld_image_count()).map {
      guard let pathC = _dyld_get_image_name($0) else {
        return nil
      }
      let path = String(cString: pathC)
      let imageName = path
        .components(separatedBy: "/")
        .last?
        .components(separatedBy: ".")
        .first
      print(path)
      return imageName
    }
    guard
      let imageIndex = allImageNames.firstIndex(of: moduleName)
    else {
      return nil
    }

    // Follows same approach here:  https://github.com/apple/swift-testing/blob/main/Sources/TestingInternals/Discovery.cpp#L318
    guard
      let headerRawPtr: UnsafeRawPointer = _dyld_get_image_header(.init(imageIndex))
        .map(UnsafeRawPointer.init(_:))
    else {
      return nil
    }
    let headerPtr = headerRawPtr.assumingMemoryBound(
      to: mach_header_64.self
    )
    // https://derekselander.github.io/dsdump/
    var size: UInt = 0
    guard
      let sectionRawPtr = getsectiondata(
        headerPtr,
        SEG_TEXT,
        "__swift5_types",
        &size
      )
      .map(UnsafeRawPointer.init(_:))
    else {
      return nil
    }
    let capacity: Int = .init(size) / MemoryLayout<SwiftTypeMetadataRecord>.size
    let sectionPtr = sectionRawPtr.assumingMemoryBound(
      to: SwiftTypeMetadataRecord.self
    )
    return (0 ..< capacity).compactMap { index in
      let record = sectionPtr.advanced(by: index)
      guard
        let contextDescriptor = record.pointee.contextDescriptor(
          from: record
        )
      else {
        return nil
      }
      guard !contextDescriptor.pointee.isGeneric() else {
        return nil
      }
      guard
        contextDescriptor.pointee.kind().canConformToProtocol,
        !filterByStorybookPageMacro || self._magicSubstring.withCString(
          {
            let nameCString = contextDescriptor.resolvePointer(for: \.name)
            return nil != strstr(nameCString, $0)
          }
        )
      else {
        return nil
      }
      let metadataClosure = contextDescriptor.resolveValue(for: \.metadataAccessFunction)
      let metadata = metadataClosure(0xFF)
      guard
        let metadataAccessFunction = metadata.value
      else {
        return nil
      }
      let anyType = unsafeBitCast(
        metadataAccessFunction,
        to: Any.Type.self
      )
      guard let bookProviderType = anyType as? any BookProvider.Type else {
        return nil
      }
      return bookProviderType
    }
  }
}

extension UnsafePointer where Pointee: SwiftLayoutPointer {

  func resolvePointer<U>(for keyPath: KeyPath<Pointee, SwiftRelativePointer<U>>) -> UnsafePointer<U> {
    let base: UnsafeRawPointer = .init(self)
    let fieldOffset = MemoryLayout<Pointee>.offset(of: keyPath)!
    let relativePointer = self.pointee[keyPath: keyPath]
    return base
      .advanced(by: fieldOffset)
      .advanced(by: .init(relativePointer.offset))
      .assumingMemoryBound(to: U.self)
  }

  func resolveValue<U>(for keyPath: KeyPath<Pointee, SwiftRelativePointer<U>>) -> U {
    let base: UnsafeRawPointer = .init(self)
    let fieldOffset = MemoryLayout<Pointee>.offset(of: keyPath)!
    let relativePointer = self.pointee[keyPath: keyPath]
    let pointer = base
      .advanced(by: fieldOffset)
      .advanced(by: .init(relativePointer.offset))
    return unsafeBitCast(pointer, to: U.self)
  }
}

protocol SwiftLayoutPointer {
  static var maskValue: Int32 { get }
}

extension SwiftLayoutPointer {
  static var maskValue: Int32 {
    return 0
  }
}

struct SwiftRelativePointer<T> {

  var offset: Int32 = 0

  func pointer(
    from base: UnsafeRawPointer,
    vmAddrSlide: Int
  ) -> UnsafePointer<T>? {
    let maskedOffset: Int = .init(offset)
    guard maskedOffset != 0 else {
      return nil
    }
    return base
      .advanced(by: -vmAddrSlide)
      .advanced(by: maskedOffset)
      .assumingMemoryBound(to: T.self)
  }
}

extension SwiftRelativePointer where T: SwiftLayoutPointer {

  func value() -> Int32 {
    offset & T.maskValue
  }

  func pointer(
    from base: UnsafeRawPointer
  ) -> UnsafePointer<T>? {
    let maskedOffset: Int = .init(offset & ~T.maskValue)
    guard maskedOffset != 0 else {
      return nil
    }
    return base
      .advanced(by: maskedOffset)
      .assumingMemoryBound(to: T.self)
  }
}

struct SwiftTypeMetadataRecord: SwiftLayoutPointer {

  var pointer: SwiftRelativePointer<SwiftTypeContextDescriptor>

  func contextDescriptor(
    from base: UnsafeRawPointer
  ) -> UnsafePointer<SwiftTypeContextDescriptor>? {
    switch pointer.value() {
    case 0:
      return pointer.pointer(from: base)

    case 1:
      // Untested
      return pointer.pointer(from: base).map {
        let indirection: UnsafeRawPointer = .init($0)
        return indirection
          .assumingMemoryBound(to: UnsafePointer<SwiftTypeContextDescriptor>.self)
          .pointee
      }

    default:
      return nil
    }
  }
}

struct SwiftTypeContextDescriptor: SwiftLayoutPointer {
  var flags: UInt32 = 0
  var parent: SwiftRelativePointer<UInt8> = .init()
  var name: SwiftRelativePointer<CChar> = .init()
  var metadataAccessFunction: SwiftRelativePointer<(@convention(thin) (Int) -> MetadataAccessResponse)> = .init()

  func isGeneric() -> Bool {
    return (flags & 0x80) != 0
  }

  func kind() -> Kind {
    // https://github.com/blacktop/go-macho/blob/master/types/swift/types.go#L589
    return .init(rawValue: flags & 0x1F)
  }

  struct MetadataAccessResponse: SwiftLayoutPointer {
    var value: UnsafeRawPointer?
    var state: Int = 0
  }

  static let maskValue: Int32 = .init(MemoryLayout<Int32>.alignment - 1)

  struct Kind: RawRepresentable, Equatable {
    static let module: Self = .init(rawValue: 0)
    static let `extension`: Self = .init(rawValue: 1)
    static let anonymous: Self = .init(rawValue: 2)
    static let `protocol`: Self = .init(rawValue: 3)
    static let opaqueType: Self = .init(rawValue: 4)

    static let typesStart: Self = .init(rawValue: 16)

    static let classType: Self = .init(rawValue: Self.typesStart.rawValue)
    static let structType: Self = .init(rawValue: Self.typesStart.rawValue + 1)
    static let enumType: Self = .init(rawValue: Self.typesStart.rawValue + 2)

    static let typesEnd: Self = .init(rawValue: 31)

    let rawValue: UInt32

    init(rawValue: UInt32) {
      self.rawValue = rawValue
    }

    var canConformToProtocol: Bool {
      return (Self.classType.rawValue ... Self.typesEnd.rawValue).contains(self.rawValue)
    }
  }
}
