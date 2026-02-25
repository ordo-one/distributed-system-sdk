// swift-tools-version: 6.2
import PackageDescription

var url: String {
    #if os(macOS)
    "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/362359171"
    #else
    "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/362359170"
    #endif
}
var checksum: String {
    #if os(macOS)
    "ebf386c425bc17a0f759b124dcbd407184ec9db2241f001f7555185ff7c75c75"
    #else
    "161579e5e91c7ce3d7d72685c203e71e01a1d23655724df410d9e6712fc105f1"
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
