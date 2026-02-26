// swift-tools-version: 6.2
import PackageDescription

var url: String {
    #if os(macOS)
    "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/363049224"
    #else
    "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/363049223"
    #endif
}
var checksum: String {
    #if os(macOS)
    "9f363163c596176ac67ae3cc25c52b3a46f0a4dd84906338b51d0d2fab802068"
    #else
    "5e90bdd49e67269a2804024582d0b915856f2f64cecc80ce2c44854e5d9be8ba"
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
