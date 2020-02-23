// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let products: [Product] = [
    
]

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/vapor/vapor", from: "4.0.0-beta"),
    .package(url: "https://github.com/vapor/mysql-kit", from: "4.0.0-beta")
]

let targets: [Target] = [
    .target(
        name: "WurlStore",
        dependencies: ["Vapor", "MySQLKit"]
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
