// swift-tools-version: 6.2
import PackageDescription

let tag: String = "0.0.1"
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
    "1cb36e7c69b1f48a5bc709767a843edb7d73095e285c378037ea76312aa624df"
    #else
    "8f95a86e3026532ab8550feec2d702c15cad5545c905610ad4c3cd3c9d975116"
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
