// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BanterURL",
    products: [
        .executable(name: "BanterURL", targets: ["BanterURL"])
    ],
    dependencies: [
        .package(url: "https://github.com/Davidde94/Jupiter", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Server",
            dependencies: ["Jupiter"]),
        .target(
            name: "BanterURL",
            dependencies: ["Server", "Jupiter"]),
        .testTarget(
            name: "BanterURLTests",
            dependencies: ["BanterURL"]),
    ]
)
