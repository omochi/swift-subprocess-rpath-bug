// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-subprocess-rpath-bug",
    platforms: [.macOS(.v15)],
    products: [
        .executable(name: "Bug", targets: ["Bug"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-subprocess", from: "0.1.0"),
    ],
    targets: [
        .executableTarget(
            name: "Bug",
            dependencies: [
                .product(name: "Subprocess", package: "swift-subprocess"),
            ]
        ),
    ]
)
