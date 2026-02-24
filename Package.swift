// swift-tools-version: 6.2
import PackageDescription

let tag: String = "0.0.1"
var url: String {
    let release: String = "https://github.com/ordo-one/internal-distributed-system/releases/download/\(tag)"
    #if os(macOS)
    return "\(release)/DistributedABI-macOS.xcframework.zip"
    #else
    return "\(release)/DistributedABI-Linux.xcframework.zip"
    #endif
}
var checksum: String {
    #if os(macOS)
    "8a0ac104d6cd029bb5dc754791e86c0d5eb00d88da2606ea5b333c0e176df4df"
    #else
    "057ed554b0ec11043a2f4449b90b77a9bf39d8488d14978163df7a3888578a2d"
    #endif
}

let package: Package = .init(
    name: "internal-distributed-system",
    products: [
        .library(name: "DistributedABI", targets: ["DistributedABI"])
    ],
    targets: [
        .binaryTarget(name: "DistributedABI", url: url, checksum: checksum),
    ]
)
