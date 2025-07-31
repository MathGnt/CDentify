// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let baseDeps: [PackageDescription.Target.Dependency] = [
  .product(name: "DataSources", package: "Data"),
  .product(name: "Repositories", package: "Data"),
  .product(name: "Protocols", package: "Domain"),
  .product(name: "UseCases", package: "Domain")
]

let package = Package(
    name: "Router",
    platforms: [.iOS(.v26), .macOS(.v26)],
    products: [
        .library(name: "Dependencies", targets: ["Dependencies"]),
    ],
    dependencies: [
        .package(name: "Data", path: "../Data"),
        .package(name: "Domain", path: "../Domain"),
    ],
    targets: [
        .target(
            name: "Dependencies",
            dependencies: baseDeps,
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ],
        ),
    ],
    swiftLanguageModes: [.v6]
)
