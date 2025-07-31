// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let baseDeps: [PackageDescription.Target.Dependency] = [
    .product(name: "DesignSystem", package: "Core"),
    .product(name: "Protocols", package: "Domain"),
    .product(name: "Entities", package: "Domain"),
]

let package = Package(
    name: "Data",
    platforms: [.iOS(.v26), .macOS(.v26)],
    products: [
        .library(name: "DataSources", targets: ["DataSources"]),
        .library(name: "Repositories", targets: ["Repositories"]),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Domain", path: "../Domain")
    ],
    targets: [
        .target(
            name: "DataSources",
            dependencies: baseDeps,
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
        .target(
            name: "Repositories",
            dependencies: baseDeps + [
                .target(name: "DataSources")
            ],
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
