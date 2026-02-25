// swift-tools-version: 6.2
import PackageDescription

var url: String {
    #if os(macOS)
    "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/362347690"
    #else
    "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/362347691"
    #endif
}
var checksum: String {
    #if os(macOS)
    "64e0b4d30170f3a65a9fccaece8122ec17772d348953039453fd9ae1a5eb9212"
    #else
    "8f6a68fe5e1c77956514ef2ad4c0781fa89cb88e9fea2f7a93f07f1957352f1b"
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
