// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VoteKit-SwiftUI",
    platforms: [
         .iOS(.v15)
    ],
    products: [
        .library(
            name: "VoteKit-SwiftUI",
            targets: ["VoteKit-SwiftUI"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/ControlKit/ControlKitBase.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "VoteKit-SwiftUI",
            dependencies: ["ControlKitBase"],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "VoteKit-SwiftUITests",
            dependencies: ["VoteKit-SwiftUI"]
        ),
    ]
)
