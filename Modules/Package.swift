// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Modules",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        // MARK: - Core
        .library(name: "Core-DesignSystem", targets: ["Core-DesignSystem"]),
        .library(name: "Core-Resources", targets: ["Core-Resources"]),

        // MARK: - Features
        .library(name: "Feature-LaunchScreen", targets: ["Feature-LaunchScreen"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Core-DesignSystem",
            dependencies: []
        ),
        .target(
            name: "Core-Resources",
            dependencies: [],
            resources: [.process("Resources")]
        ),
        .target(
            name: "Feature-LaunchScreen",
            dependencies: []
        )
    ]
)
