// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let products: [Product] = [
    
]

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/vapor/vapor", .exact("4.0.0-rc.3.1")),
    .package(url: "https://github.com/vapor/fluent-mysql-driver", .exact("4.0.0-rc.1.1"))
]

let targets: [Target] = [
    .target(
        name: "WurlStore",
        dependencies: ["Vapor", "Wordset"]
    ),
    .target(
        name: "Wordset",
        dependencies: ["Vapor"]
    ),
    .testTarget(
        name: "WordsetTests",
        dependencies: ["Wordset"]
    ),
]

let package = Package(
    name: "3wurl",
    platforms: [
        .macOS(.v10_15),
    ],
    products: products,
    dependencies: dependencies,
    targets: targets
)
