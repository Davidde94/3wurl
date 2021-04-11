// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
 
let products: [Product] = [
    .executable(name: "WurlServe", targets: ["WurlServe"]),
    .executable(name: "WurlAPI", targets: ["WurlAPI"]),
    .executable(name: "WurlRedirect", targets: ["WurlRedirect"]),
]

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/vapor/vapor", from: "4.36.0"),
    .package(url: "https://github.com/vapor/mysql-kit", from: "4.1.0"),
    .package(url: "https://github.com/vapor/leaf", from: "4.0.0"),
]

let targets: [Target] = [
    .target(name: "WurlServe", dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "Leaf", package: "leaf"),
        "WurlStore",
        "Wordset"
    ],resources: [.copy("Resources/host.json")]

           ),
    .target(name: "WurlRedirect", dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "MySQLKit", package: "mysql-kit"),
        "WurlStore",
    ],
            resources: [
                .copy("Resources/host.json"),
                .copy("Resources/database.json"),
            ]
            ),
    .target(
            name: "WurlAPI",
            dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "MySQLKit", package: "mysql-kit"),
        "WurlStore",
    ],
            resources: [.copy("Resources/host.json"), .copy("Resources/database.json")]

            ),
    .target(
            name: "WurlStore",
            dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "MySQLKit", package: "mysql-kit"),
        "Wordset"
    ]
            ),
    .target(
            name: "Wordset",
            dependencies: [.product(name: "Vapor", package: "vapor")],
                    resources: [
                        .copy("Resources/Wordset1.json"),
                        .copy("Resources/Wordset2.json"),
                        .copy("Resources/Wordset3.json")
                    ]
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
