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
        "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/410965354"
        #else
        "https://api.github.com/repos/ordo-one/internal-distributed-system/releases/assets/410965355"
        #endif
    }
    var checksum: String {
        #if os(macOS)
        "aeb49c6fd3dba62a17768258b4860b29c9096841db89ba6e5ec1230eeff52d12"
        #else
        "2b62c579b315b1b993ea7af9f2ae21daf0fccb045a6f893d1cc592f8ced07520"
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
