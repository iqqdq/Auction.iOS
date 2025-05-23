// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "socket.io-test",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(name: "socket.io-test", targets: ["YourTargetName"])
            
        .library(
            name: "Auction",
            targets: ["Auction"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/socketio/socket.io-client-swift", .upToNextMinor(from: "13.3.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "YourTargetName", dependencies: ["SocketIO"], path: "./Path/To/Your/Sources"),
        .testTarget(
            name: "AuctionTests",
            dependencies: ["SocketIO"]),
    ]
)
