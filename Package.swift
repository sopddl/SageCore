// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SageCore",
    platforms: [
        .iOS(.v17),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "SageCore",
            targets: ["SageCore"]
        )
    ],
    targets: [
        .target(
            name: "SageCore",
            dependencies: [],
            path: "Sources/SageCore"
        ),
        .testTarget(
            name: "SageCoreTests",
            dependencies: ["SageCore"],
            path: "Tests/SageCoreTests"
        )
    ]
)
