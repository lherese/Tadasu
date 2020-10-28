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
      ],
      resources: [
        .process("Resources"),
      ]
    ),
    .testTarget(
      name: "TadasuTests",
      dependencies: [
        "Tadasu",
      ]
    ),
    .testTarget(
      name: "NorwayTests",
      dependencies: [
        "Tadasu",
      ]
    ),
  ]
)
