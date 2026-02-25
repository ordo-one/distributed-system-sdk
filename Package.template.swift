// swift-tools-version: 6.2
import PackageDescription

var url: String {
    #if os(macOS)
    "__ASSET_URL_MACOS__"
    #else
    "__ASSET_URL_LINUX__"
    #endif
}
var checksum: String {
    #if os(macOS)
    "__CHECKSUM_MACOS__"
    #else
    "__CHECKSUM_LINUX__"
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
