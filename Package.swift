// swift-tools-version:5.8
import PackageDescription

let package = Package(
  name: "Storybook",
  platforms: [
    .iOS(.v14)
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
    .package(url: "https://github.com/FluidGroup/ResultBuilderKit", from: "1.3.0")
  ],
  targets: [
    .target(
      name: "StorybookKit",
      dependencies: [
        .product(name: "SwiftUISupport", package: "swiftui-support"),
        "ResultBuilderKit"
      ]
    ),
    .target(
      name: "StorybookKitTextureSupport",
      dependencies: [
        .product(name: "TextureSwiftSupport", package: "TextureSwiftSupport"),
        .product(name: "TextureBridging", package: "TextureBridging"),
        "StorybookKit",
      ]
    ),
  ]
)
