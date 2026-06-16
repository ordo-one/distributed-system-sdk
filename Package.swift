// swift-tools-version: 6.2
import PackageDescription
import Foundation

let package: Package = .init(
    name: "distributed-system-sdk",
    products: [
        .library(name: "OrdoDistributedABI", targets: ["DistributedABI"])
    ],
    targets: [
        DistributedABI,
    ]
)

var DistributedABI: Target {
    var url: String {
        #if os(macOS)
        "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/449643573"
        #else
        "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/449643574"
        #endif
    }
    var checksum: String {
        #if os(macOS)
        "33a7f41eceee5d92b5a7fc1d4b4804b2bf33d5e7defab37b5dd6b5e3152ed5bc"
        #else
        "38369f8de71de23d46b8abb629823d4aefb9f3af0175894fac41696e31f3f040"
        #endif
    }
    var localSDK: String? {
        switch ProcessInfo.processInfo.environment["ORDO_SDK_DISTRIBUTED_LOCAL"]?.lowercased() {
        case "1"?, "yes"?, "true"?:
            break
        case "0"?, "no"?, "false"?, nil:
            return nil
        case let unsupported?:
            print("unsupported value '\(unsupported)' for ORDO_SDK_DISTRIBUTED_LOCAL")
            // this is certain to fail the client build, which is what we want
            return ""
        }

        guard
        let ordo: String = ProcessInfo.processInfo.environment["ORDO_PROJECT_DIR"] else {
            print("'ORDO_SDK_DISTRIBUTED_LOCAL' is set, but 'ORDO_PROJECT_DIR' is not")
            return ""
        }

        // SPM only supports relative paths for local packages
        let path: String = "\(String.init(repeating: "../", count: 100))\(ordo)/internal-distributed-system"
        return path
    }

    if  let localSDK: String {
        let path: String
        #if os(macOS)
            path = "\(localSDK)/OrdoDistributedABI-macOS.xcframework"
        #else
            path = "\(localSDK)/OrdoDistributedABI-Linux.xcframework"
        #endif
        return .binaryTarget(name: "DistributedABI", path: path)
    } else {

        return .binaryTarget(name: "DistributedABI", url: "\(url).zip", checksum: checksum)
    }
}
