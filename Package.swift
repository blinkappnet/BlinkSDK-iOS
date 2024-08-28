// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BlinkSDKTarget",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "BlinkSDKTarget",
            targets: ["BlinkSDKTarget"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/blinkappnet/TensorFlowLite.git", .upToNextMajor(from: "0.2.0")),
    ],
    targets: [
        .target(
            name: "BlinkSDKTarget",
            dependencies: [
                "BlinkSDKBinary",
                .product(name: "TensorFlowLite", package: "TensorFlowLite")

            ],
            path: "",
            exclude: ["Example"]
        ),
        .binaryTarget(
            name: "BlinkSDKBinary",
            path: "./Sources/BlinkSDK.xcframework"
        )
    ]
)
