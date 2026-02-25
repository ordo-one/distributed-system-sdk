// swift-tools-version: 6.2
import PackageDescription

var url: String {
    let release: String = """
    https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets
    """
    #if os(macOS)
    return "\(release)/__ASSET_ID_MACOS__.zip"
    #else
    return "\(release)/__ASSET_ID_LINUX__.zip"
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
        .binaryTarget(name: "DistributedABI", url: url, checksum: checksum),
    ]
)
