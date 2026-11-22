// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "RibhNative",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "RibhNative", targets: ["RibhNativePlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "8.0.0")
    ],
    targets: [
        .target(
            name: "RibhNativePlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/RibhNativePlugin",
            resources: [.copy("Resources/salat_alanabi.wav")])
    ]
)
