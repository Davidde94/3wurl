// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BanterURL",
    products: [
        .executable(name: "BanterURL", targets: ["BanterURL"])
    ],
    dependencies: [
        .package(url: "https://github.com/Davidde94/Jupiter", .branch("master")),
        .package(url: "https://github.com/IBM-Swift/SwiftKueryMySQL", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", from: "1.1.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Banterbase",
            dependencies: ["SwiftKueryMySQL"]),
        .target(
            name: "Server",
            dependencies: ["Jupiter", "KituraStencil", "Banterbase"]),
        .target(
            name: "BanterURL",
            dependencies: ["Server", "Jupiter"]),
        .testTarget(
            name: "BanterURLTests",
            dependencies: ["BanterURL"]),
    ]
)
