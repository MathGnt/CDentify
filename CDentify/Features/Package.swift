// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let baseDeps: [PackageDescription.Target.Dependency] = [
  .product(name: "Entities", package: "Domain"),
  .product(name: "UseCases", package: "Domain"),
  .product(name: "Protocols", package: "Domain"),
]

let homeDeps: [PackageDescription.Target.Dependency] = [
    .target(name: "BarcodeScanner")
]

let package = Package(
    name: "Features",
    platforms: [.iOS(.v26), .macOS(.v26)],
    products: [
        .library(name: "BarcodeScanner", targets: ["BarcodeScanner"]),
        .library(name: "Home", targets: ["Home"]),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
    ],
    targets: [
        .target(
            name: "BarcodeScanner",
            dependencies: baseDeps,
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
        .target(
            name: "Home",
            dependencies: baseDeps + homeDeps,
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
