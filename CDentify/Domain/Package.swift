// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let baseDeps: [PackageDescription.Target.Dependency] = [
  .product(name: "DesignSystem", package: "Core")
]

let useCasesDeps: [PackageDescription.Target.Dependency] = baseDeps + [
    .target(name: "Protocols"),
    .target(name: "Entities")
]

let ptcDeps: [PackageDescription.Target.Dependency] = baseDeps + [
    .target(name: "Entities")
]

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v26), .macOS(.v26)],
    products: [
        .library(name: "Entities", targets: ["Entities"]),
        .library(name: "UseCases", targets: ["UseCases"]),
        .library(name: "Protocols", targets: ["Protocols"])
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
    ],
    targets: [
        .target(
            name: "Entities",
            dependencies: baseDeps,
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
        .target(name: "UseCases",
              dependencies: useCasesDeps,
               swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
        .target(name: "Protocols",
               dependencies: ptcDeps,
               swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),

    ],
    swiftLanguageModes: [.v6]
)

