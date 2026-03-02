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
        "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/365580722"
        #else
        "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/365580723"
        #endif
    }
    var checksum: String {
        #if os(macOS)
        "e8f4b8730463e3ae1bb7f0d20fd9d63f15e6b3b6961e05f5c2103874bf751703"
        #else
        "d4cb9c9a7e2a69629e54490f03a8d4c80ef0e466aa15727a4e13033149b8fff7"
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

        let path: String = "\(ordo)/internal-distributed-system"
        return path
    }

    if  let localSDK: String {
        return .binaryTarget(name: "DistributedABI", path: localSDK)
    } else {

        return .binaryTarget(name: "DistributedABI", url: "\(url).zip", checksum: checksum)
    }
}
