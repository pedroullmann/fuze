// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Modules",
    defaultLocalization: "pt-BR",
    platforms: [.iOS(.v15)],
    products: [
        // MARK: - Core
        .library(name: "Core-DesignSystem", targets: ["Core-DesignSystem"]),
        .library(name: "Core-UI", targets: ["Core-UI"]),
        .library(name: "Core-Resources", targets: ["Core-Resources"]),
        .library(name: "Core-Networking", targets: ["Core-Networking"]),
        .library(name: "Core-Networking-Interface", targets: ["Core-Networking-Interface"]),

        // MARK: - Features
        .library(name: "Feature-LaunchScreen", targets: ["Feature-LaunchScreen"]),
        .library(name: "Feature-Home", targets: ["Feature-Home"]),
        .library(name: "Feature-Home-Repository", targets: ["Feature-Home-Repository"]),
        .library(name: "Feature-Home-Repository-Live", targets: ["Feature-Home-Repository-Live"]),
        .library(name: "Feature-MatchDetails", targets: ["Feature-MatchDetails"]),

        // MARK: - Root
        .library(name: "Root-Extensions", targets: ["Root-Extensions"]),
        .library(name: "Root-Elements", targets: ["Root-Elements"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/combine-schedulers",
            from: "0.9.1"
        )
    ],
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
            name: "Core-Networking",
            dependencies: [
                "Core-Networking-Interface"
            ]
        ),
        .target(
            name: "Core-Networking-Interface",
            dependencies: []
        ),
        .target(
            name: "Feature-LaunchScreen",
            dependencies: [
                "Core-DesignSystem",
                "Core-Resources",
                "Core-UI",
                "Root-Elements",
                "Feature-Home",
                "Feature-Home-Repository"
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
        .testTarget(
            name: "Root-Elements-Tests",
            dependencies: [
                "Root-Elements"
            ]
        ),
        .target(
            name: "Feature-Home",
            dependencies: [
                "Core-DesignSystem",
                "Core-Resources",
                "Core-UI",
                "Root-Elements",
                "Feature-Home-Repository",
                .product(name: "CombineSchedulers", package: "combine-schedulers"),
                "Feature-MatchDetails"
            ]
        ),
        .testTarget(
            name: "Feature-Home-Tests",
            dependencies: [
                "Feature-Home",
                "Feature-Home-Repository",
                "Root-Elements",
                "Core-Networking-Interface"
            ]
        ),
        .target(
            name: "Feature-Home-Repository",
            dependencies: [
                "Core-Networking-Interface"
            ]
        ),
        .target(
            name: "Feature-Home-Repository-Live",
            dependencies: [
                "Feature-Home-Repository",
                "Core-Networking",
                "Core-Networking-Interface"
            ]
        ),
        .target(
            name: "Feature-MatchDetails",
            dependencies: [
                "Feature-Home-Repository",
                "Core-UI",
                "Core-DesignSystem"
            ]
        )
    ]
)
