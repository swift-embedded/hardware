// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Hardware",
    products: [
        .library(name: "Hardware", targets: ["Hardware"]),
        .library(name: "UARTLogHandler", targets: ["UARTLogHandler"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "UARTLogHandler", dependencies: ["Logging", "Hardware"]),
        .target(name: "Hardware", dependencies: ["HardwareExt"]),
        .target(name: "HardwareExt"),
    ]
)
