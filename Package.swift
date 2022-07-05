// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "Storybook",
  platforms: [
    .iOS(.v12)
  ],
  products: [
    .library(name: "StorybookKit", targets: ["StorybookKit"]),
    .library(name: "StorybookKitTextureSupport", targets: ["StorybookKitTextureSupport"]),
    .library(name: "StorybookUI", targets: ["StorybookUI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/muukii/MondrianLayout.git", from: "0.8.0"),
    .package(url: "https://github.com/FluidGroup/TextureBridging.git", branch: "main"),
    .package(url: "https://github.com/FluidGroup/TextureSwiftSupport.git", branch: "main"),
  ],
  targets: [
    .target(
      name: "StorybookKit",
      dependencies: [],
      path: "StorybookKit"
    ),
    .target(
      name: "StorybookKitTextureSupport",
      dependencies: [
        .product(name: "TextureSwiftSupport", package: "TextureSwiftSupport"),
        .product(name: "TextureBridging", package: "TextureBridging"),
        "StorybookKit",
      ],
      path: "StorybookKitTextureSupport"
    ),
    .target(
      name: "StorybookUI",
      dependencies: ["StorybookKit", "MondrianLayout"],
      path: "StorybookUI"
    ),
  ]
)
