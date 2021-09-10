// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ServiceBoard",
    
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ServiceBoard",
            targets: ["ServiceBoard"]
        )
    ],

    dependencies: [
      // Dependencies declare other packages that this package depends on.
      .package(
        url: "https://github.com/Swinject/Swinject.git",
        from: "2.8.1"
      )
    ],
    
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ServiceBoard",
            dependencies: [
              .product(name: "Swinject", package: "Swinject")
            ],
            path: "Sources")
    ],
    
    
  
    
    swiftLanguageVersions: [
        .v5
    ]
)
