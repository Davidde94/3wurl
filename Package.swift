// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let products: [Product] = [
    .executable(name: "3wurl", targets: ["3wurl"]),
    .executable(name: "3wurlRedirect", targets: ["3wurlRedirect"]),
    .library(name: "Jupiter", targets: ["Jupiter"])
]

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/IBM-Swift/Kitura", .upToNextMinor(from: "2.9.0")),
    .package(url: "https://github.com/IBM-Swift/SwiftKueryMySQL", .upToNextMinor(from: "2.0.0")),
    .package(url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", .upToNextMinor(from: "1.11.0")),
    .package(url: "https://github.com/IBM-Swift/HeliumLogger", .upToNextMinor(from: "1.9.0"))
]

let targets: [Target] = [
    .target(
        name: "WurlStore",
        dependencies: ["SwiftKueryMySQL", "Wordset"]
    ),
    .target(
        name: "Jupiter",
        dependencies: ["Kitura", "HeliumLogger"]
    ),
    .target(
        name: "3wurl",
        dependencies: ["Kitura", "KituraStencil", "WurlStore", "Jupiter", "Wordset"]
    ),
    .target(
        name: "3wurlRedirect",
        dependencies: ["Kitura", "KituraStencil", "WurlStore", "Jupiter"]
    ),
    .target(
        name: "Wordset",
        dependencies: []
    ),
    .testTarget(
        name: "WordsetTests",
        dependencies: ["Wordset"]
    ),
]

let package = Package(
    name: "3wurl",
    products: products,
    dependencies: dependencies,
    targets: targets
)
