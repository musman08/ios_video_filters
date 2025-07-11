// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "video_filters",
    platforms: [
        .iOS("14.0")
    ],
    products: [
        .library(name: "video-filters", targets: ["video_filters"])
    ],
    dependencies: [
        .package(url:"https://github.com/ronan18/SwiftCube.git", branch: "main")
    ],
    targets: [
        .target(
            name: "video_filters",
            dependencies: [
                "SwiftCube"
            ],
            resources: [
                // If your plugin requires a privacy manifest, for example if it uses any required
                // reason APIs, update the PrivacyInfo.xcprivacy file to describe your plugin's
                // privacy impact, and then uncomment these lines. For more information, see
                // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
                .process("PrivacyInfo.xcprivacy"),

                // If you have other resources that need to be bundled with your plugin, refer to
                // the following instructions to add them:
                // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
            ],
            cSettings: [
                .headerSearchPath("include/video_filters"),
            ]
        )
    ]
)
