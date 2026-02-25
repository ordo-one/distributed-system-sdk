// swift-tools-version: 6.2
import PackageDescription

var url: String {
    #if os(macOS)
    "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/362286304"
    #else
    "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/362286303"
    #endif
}
var checksum: String {
    #if os(macOS)
    "8c4542b7c53ad56eece99c43fd28d855f561e1e97c5792b8a483880dbb3423bf"
    #else
    "985ea99eb9bb2d4cd20a95b848cbc5eed74efc579b70d907e00428bede138846"
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
