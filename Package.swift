// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "swiftui-frameless-window",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "FramelessWindow",
            targets: ["FramelessWindow"])
    ],
    targets: [
        .target(
            name: "FramelessWindow",
            dependencies: [])
    ]
)
