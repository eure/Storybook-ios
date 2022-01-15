// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Storybook",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(name: "StorybookKit", targets: ["StorybookKit"]),
        .library(name: "StorybookUI", targets: ["StorybookUI"])
    ],
    dependencies: [
        .package(url: "https://github.com/muukii/MondrianLayout.git", from: "0.8.0")
    ],
    targets: [
        .target(
            name: "StorybookKit",
            dependencies: [],
            path: "StorybookKit"
        ),
        .target(
            name: "StorybookUI",
            dependencies: ["StorybookKit", "MondrianLayout"],
            path: "StorybookUI"
        )
    ]
)
