// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DiStorage",
    // platforms: [
    //     .iOS(.v10),
    //     .macOS(.v10.15)
    // ],
    products: [
        .library(
            name: "DiStorage",
            targets: ["DiStorage"]),
    ],
    targets: [
        .target(
            name: "DiStorage",
            path: "Sources/DiStorage",
            exclude: []
        ),
        .testTarget(
            name: "DiStorageTests",
            dependencies: ["DiStorage"],
            path: "Tests/DiStorageTests"
        )
    ]
)
