// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Hardware",
    products: [
        .library(
            name: "Hardware",
            targets: ["Hardware"]
        ),
    ],
    targets: [
        .target(name: "Hardware", dependencies: ["HardwareExt"]),
        .target(name: "HardwareExt"),
    ]
)
