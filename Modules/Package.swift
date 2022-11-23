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
        .library(name: "Feature-LaunchScreen", targets: ["Feature-LaunchScreen"]),

        // MARK: - Root
        .library(name: "Root-Extensions", targets: ["Root-Extensions"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Core-DesignSystem",
            dependencies: [
                "Root-Extensions"
            ]
        ),
        .target(
            name: "Core-Resources",
            dependencies: [],
            resources: [.process("Resources")]
        ),
        .target(
            name: "Feature-LaunchScreen",
            dependencies: [
                "Core-DesignSystem",
                "Core-Resources"
            ]
        ),
        .target(
            name: "Root-Extensions",
            dependencies: []
        )
    ]
)
