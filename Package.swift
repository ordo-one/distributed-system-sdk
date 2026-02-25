// swift-tools-version: 6.2
import PackageDescription

var url: String {
    #if os(macOS)
    "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/362355745"
    #else
    "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/362355744"
    #endif
}
var checksum: String {
    #if os(macOS)
    "5bb54c264bae352c4e57cfe831f34beb0c54bc4468f0cc10afc5bfa8d13c3c98"
    #else
    "fdfaa59f4a81e37a79345f1e42781cb5b993cd7b412547cd14f3fbdc3b532e96"
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
