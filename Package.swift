// swift-tools-version:5.9
import PackageDescription
import CompilerPluginSupport

let package = Package(
  name: "Storybook",
  platforms: [
    .iOS(.v15),
    .macCatalyst(.v15),
    .macOS(.v10_15)
  ],
  products: [
    .library(name: "StorybookKit", targets: ["StorybookKit"]),
    .library(name: "StorybookKitTextureSupport", targets: ["StorybookKitTextureSupport"]),
  ],
  dependencies: [
    .package(url: "https://github.com/muukii/MondrianLayout.git", from: "0.8.0"),
    .package(url: "https://github.com/FluidGroup/TextureBridging.git", branch: "main"),
    .package(url: "https://github.com/FluidGroup/TextureSwiftSupport.git", branch: "main"),
    .package(url: "https://github.com/FluidGroup/swiftui-support", from: "0.4.1"),
    .package(url: "https://github.com/FluidGroup/ResultBuilderKit", from: "1.3.0"),
    .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-macro-testing.git", branch: "main")
  ],
  targets: [
    .target(
      name: "StorybookKit",
      dependencies: [
        "StorybookMacrosPlugin",
        .product(name: "SwiftUISupport", package: "swiftui-support"),
        "ResultBuilderKit"
      ]
    ),
    .macro(
      name: "StorybookMacrosPlugin",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]
    ),
    .testTarget(
      name: "StorybookMacrosTests",
      dependencies: [
        "StorybookMacrosPlugin",
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
        .product(name: "MacroTesting", package: "swift-macro-testing"),
      ]
    ),
    .target(
      name: "StorybookKitTextureSupport",
      dependencies: [
        .product(name: "TextureSwiftSupport", package: "TextureSwiftSupport"),
        .product(name: "TextureBridging", package: "TextureBridging"),
        "StorybookKit",
      ]
    )
  ]
)
