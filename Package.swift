// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Tadasu",
  products: [
    .library(
      name: "Tadasu",
      targets: [
        "Tadasu",
      ]
    ),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Tadasu",
      dependencies: [
      ]
    ),
    .testTarget(
      name: "TadasuTests",
      dependencies: [
        "Tadasu",
      ]
    ),
  ]
)
