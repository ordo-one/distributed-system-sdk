// swift-tools-version: 6.2
import PackageDescription

let tag: String = "0.1.0"
var url: String {
    let release: String = "https://github.com/ordo-one/distributed-system-sdk/releases/download/\(tag)"
    #if os(macOS)
    return "\(release)/DistributedABI-macOS.xcframework.zip"
    #else
    return "\(release)/DistributedABI-Linux.xcframework.zip"
    #endif
}
var checksum: String {
    #if os(macOS)
    "aa6bbad9dea16e40c70ba31e1b7bb23d489ea5ee0d0f693ed42575f64c8afdba"
    #else
    "6a3348577e690a3d6a850917773b8f017c752e90322c4dd2ded7ab6d7eb8269b"
    #endif
}

let package: Package = .init(
    name: "distributed-system-sdk",
    products: [
        .library(name: "DistributedABI", targets: ["DistributedABI"])
    ],
    targets: [
        .binaryTarget(name: "DistributedABI", url: url, checksum: checksum),
    ]
)
