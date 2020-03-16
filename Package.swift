// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let products: [Product] = [
    .executable(name: "WurlServe", targets: ["WurlServe"]),
    .executable(name: "WurlAPI", targets: ["WurlAPI"]),
    .executable(name: "WurlRedirect", targets: ["WurlRedirect"]),
]

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/vapor/vapor", .exact("4.0.0-rc.3.4")),
    .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-rc.1"),
    .package(url: "https://github.com/vapor/fluent-mysql-driver", .exact("4.0.0-rc.1.1")),
    .package(url: "https://github.com/vapor/leaf", .exact("4.0.0-rc.1.1")),
]

let targets: [Target] = [
    .target(name: "WurlServe", dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "Leaf", package: "leaf"),
        "WurlStore",
        "Wordset"
    ]),
    .target(name: "WurlRedirect", dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
        .product(name: "Fluent", package: "fluent"),
        "WurlStore",
    ]),
    .target(name: "WurlAPI", dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
        .product(name: "Fluent", package: "fluent"),
        "WurlStore",
    ]),
    .target(
        name: "WurlStore",
        dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
            .product(name: "Fluent", package: "fluent"),
            "Wordset"
        ]
    ),
    .target(
        name: "Wordset",
        dependencies: [.product(name: "Vapor", package: "vapor")]
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
