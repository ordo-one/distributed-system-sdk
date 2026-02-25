// swift-tools-version: 6.2
import PackageDescription

var url: String {
    #if os(macOS)
    "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/362290272"
    #else
    "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/362290273"
    #endif
}
var checksum: String {
    #if os(macOS)
    "b883c4a9a87670e7841c1805b120792afd6fea1209c6c98e9cdcc5c900c25821"
    #else
    "d02af3f289aeda28ad2864e1b37080cc0499f1c557610f44148f70e2588d0b01"
    #endif
}

let package: Package = .init(
    name: "distributed-system-sdk",
    products: [
        .library(name: "DistributedABI", targets: ["DistributedABI"])
    ],
    targets: [
        .binaryTarget(name: "DistributedABI", url: "\(url).zip", checksum: checksum),
    ]
)
