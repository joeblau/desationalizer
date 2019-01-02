// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Desationalizer",
    products: [
        .executable(name: "Teach", targets: ["Teach"]),
        .executable(name: "Train", targets: ["Train"]),
        .executable(name: "Predict", targets: ["Predict"]),
        .library(name: "NewsDigest", targets: ["NewsDigest"]),
        .library(name: "Splitter", targets: ["Splitter"])
    ],
    dependencies: [
        .package(url: "https://github.com/Swiftline/Swiftline.git", from: "0.5.0"),
    ],
    targets: [
        // Executables
        .target(
            name: "Teach",
            dependencies: ["Swiftline", "NewsDigest", "Splitter"],
            path: "Sources/Executables/Teach"),
        .target(
            name: "Train",
            dependencies: [],
            path: "Sources/Executables/Train"),
        .target(
            name: "Predict",
            dependencies: [],
            path: "Sources/Executables/Predict"),
        // Libraries
        .target(name: "NewsDigest",
                dependencies: [],
                path: "Sources/Libraries/NewsDigest"),
        .target(name: "Splitter",
                dependencies: [],
                path: "Sources/Libraries/Splitter"),
        // Tests
        .testTarget(
            name: "DesationalizerTests",
            dependencies: []),
        .testTarget(
            name: "SplitterTests",
            dependencies: [],
            path: "Tests/Libraries/SplitterTests"),
        .testTarget(
            name: "NewsDigestTests",
            dependencies: [],
            path: "Tests/Libraries/NewsDigestTests")
    ]
    
)
