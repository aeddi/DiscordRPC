// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "DiscordRPC",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "DiscordRPC",
            targets: ["DiscordRPC"]
        )
    ],
    dependencies: [
        .package(name: "Socket", url: "https://github.com/IBM-Swift/BlueSocket.git", from: "2.0.1")
    ],
    targets: [
        .target(
            name: "DiscordRPC",
            dependencies: ["Socket"],
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [.v5]
)
