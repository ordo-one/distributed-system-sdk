// swift-tools-version: 6.2
import PackageDescription

let tag: String = "0.0.2"
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
    "75e363d781b572dad11dc63fb36707a4a616b029f886dc121c646e3a9f407c55"
    #else
    "b35a9d8f1a285e695ed2f929d13b920739573bbadb02a0ea971d3ef2204b2bc0"
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
