// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Desationalizer",
    products: [
        .executable(name: "Teach", targets: ["Teach"]),
        .executable(name: "Predict", targets: ["Predict"]),
        .library(name: "Splitter", targets: ["Splitter"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Teach",
            dependencies: [],
            path: "Sources/Executables/Teach"),
        .target(
            name: "Predict",
            dependencies: [],
            path: "Sources/Executables/Predict"),
        .target(name: "Splitter",
                dependencies: [],
                path: "Sources/Libraries/Splitter"),
        
        .testTarget(
            name: "DesationalizerTests",
            dependencies: []),
        .testTarget(
            name: "SplitterTests",
            dependencies: [],
            path: "Tests/Libraries/SplitterTests")
    ]
    
)