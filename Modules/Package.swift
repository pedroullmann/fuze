// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Core-DesignSystem",
            targets: ["Core-DesignSystem"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Core-DesignSystem",
            dependencies: []
        )
    ]
)
