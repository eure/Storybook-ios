// swift-tools-version:5.3
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
    dependencies: [],
    targets: [
        .target(
            name: "StorybookKit",
            dependencies: [],
            path: "StorybookKit"
        ),
        .target(
            name: "StorybookUI",
            dependencies: ["StorybookKit"],
            path: "StorybookUI"
        )
    ]
)