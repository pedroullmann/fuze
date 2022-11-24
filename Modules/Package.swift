// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Modules",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // MARK: - Core
        .library(name: "Core-DesignSystem", targets: ["Core-DesignSystem"]),
        .library(name: "Core-UI", targets: ["Core-UI"]),
        .library(name: "Core-Resources", targets: ["Core-Resources"]),

        // MARK: - Features
        .library(name: "Feature-LaunchScreen", targets: ["Feature-LaunchScreen"]),
        .library(name: "Feature-Home", targets: ["Feature-Home"]),

        // MARK: - Root
        .library(name: "Root-Extensions", targets: ["Root-Extensions"]),
        .library(name: "Root-Elements", targets: ["Root-Elements"])
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
            name: "Core-UI",
            dependencies: [
                "Core-DesignSystem",
                "Core-Resources",
                "Root-Elements"
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
                "Core-Resources",
                "Core-UI",
                "Root-Elements",
                "Feature-Home"
            ]
        ),
        .testTarget(
            name: "Feature-LaunchScreen-Tests",
            dependencies: [
                "Feature-LaunchScreen",
                "Core-Resources",
                "Root-Elements"
            ]
        ),
        .target(
            name: "Root-Extensions",
            dependencies: []
        ),
        .target(
            name: "Root-Elements",
            dependencies: []
        ),
        .target(
            name: "Feature-Home",
            dependencies: [
                "Core-DesignSystem",
                "Core-Resources",
                "Core-UI",
                "Root-Elements"
            ]
        )
    ]
)
