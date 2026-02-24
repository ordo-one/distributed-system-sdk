// swift-tools-version: 6.2
import PackageDescription

let tag: String = "0.1.1"
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
    "d66d757b3ac01e084d7e30bfa615420b9e609ffbe3d285c43826f6b8e70f64ee"
    #else
    "a88d70e66bf908540fbc13957470104033108df859a59ab8c14e42f6837144a7"
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
