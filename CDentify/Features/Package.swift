// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let baseDeps: [PackageDescription.Target.Dependency] = [
  .product(name: "Entities", package: "Domain"),
  .product(name: "UseCases", package: "Domain"),
  .product(name: "Protocols", package: "Domain"),
]


let package = Package(
    name: "Features",
    platforms: [.iOS(.v26), .macOS(.v26)],
    products: [
        .library(name: "Views", targets: ["Views"]),
        .library(name: "Models", targets: ["Models"])
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "Router", path: "../Router")
    ],
    targets: [
        .target(
            name: "Views",
            dependencies: [
                .target(name: "Models"),
                .product(name: "Dependencies", package: "Router")
                ],
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
        .target(
            name: "Models",
            dependencies: baseDeps,
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
        .testTarget(
          name: "ScannerTests",
          dependencies: [
            .target(name: "Models"),
            .product(name: "Dependencies", package: "Router"),
          ],
          swiftSettings: [
            .defaultIsolation(MainActor.self)
          ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
