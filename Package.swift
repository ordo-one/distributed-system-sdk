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
        "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/380417582"
        #else
        "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/380417580"
        #endif
    }
    var checksum: String {
        #if os(macOS)
        "6b09f1cc0245e0b2e304d6cd41fbaaa23aee6158f0517d9b67d694faf28cea2d"
        #else
        "72fb96a49e48ff4fcef26eb49048aaad6ea07e093d22304456503a517da65e1a"
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
