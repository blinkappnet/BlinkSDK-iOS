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
        .package(url: "https://github.com/tareksabry1337/TensorFlowLiteSwift.git", exact: "2.9.1"),
    ],
    targets: [
        .target(
            name: "BlinkSDKTarget",
            dependencies: [
                "BlinkSDKBinary",
                .product(name: "TensorFlowLiteSwift", package: "TensorFlowLiteSwift")

            ],
            path: "",
            exclude: ["Example", "Framework"]
        ),
        .binaryTarget(
            name: "BlinkSDKBinary",
            path: "./Sources/BlinkSDK.xcframework"
        )
    ]
)
