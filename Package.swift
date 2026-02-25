// swift-tools-version: 6.2
import PackageDescription

var url: String {
    #if os(macOS)
    "null"
    #else
    "null"
    #endif
}
var checksum: String {
    #if os(macOS)
    "60111543622a39e5d9b71096ca5bd9cc61e939d4756e4b7e49327c04c4450daa"
    #else
    "babbad9de27f2c628a7930bc84c0663855a190363c8975bbabae5a4a62e0b5dd"
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
