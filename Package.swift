// swift-tools-version: 6.2
import PackageDescription
import Foundation

let package: Package = .init(
    name: "distributed-system-sdk",
    products: [
        .library(name: "DistributedABI", targets: ["DistributedABI"])
    ],
    targets: [
        DistributedABI,
    ]
)

var DistributedABI: Target {
    var url: String {
        #if os(macOS)
        "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/365597481"
        #else
        "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/365597480"
        #endif
    }
    var checksum: String {
        #if os(macOS)
        "5361c19cea8d9f5bb51ace1744efdba5aa0368f45798157f9b7a416f61b05857"
        #else
        "6b6ccb10157c646e0d23e2c38b329238f3987b9a82ae8a6130efab16c9d60b77"
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
        return .binaryTarget(name: "DistributedABI", path: localSDK)
    } else {

        return .binaryTarget(name: "DistributedABI", url: "\(url).zip", checksum: checksum)
    }
}
