// swift-tools-version:5.6

// Copyright 2023 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import PackageDescription

let package = Package(
  name: "gRPC",
  products: [
    .library(
      name: "gRPC-Core",
      targets: ["gRPC-Core"]
    ),
    .library(
      name: "gRPC-C++",
      targets: ["gRPC-CXX-Target"]
    ),
  ],
  dependencies: [
    .package(
        url: "https://github.com/google/abseil-cpp-binary.git",
        "1.2022062300.0" ..< "1.2022062400.0"
    )
  ],
  targets: [
    .target(
      name: "gRPC-CXX-Target",
      dependencies: [
        .target(name: "gRPC-CXX-Wrapper")
      ],
      path: "SwiftPM-PlatformExclude/gRPC-CXX-Target"
    ),
    .target(
      name: "gRPC-CXX-Wrapper",
      dependencies: [
        .target(name: "gRPC-Core"),
        .target(name: "gRPC-C++"),
        .target(name: "BoringSSL-GRPC"),
        .product(name: "abseil", package: "abseil-cpp-binary"),
      ],
      path: "gRPC-CXX-Wrapper"
    ),
    .binaryTarget(
      name: "gRPC-Core",
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.50.1/gRPC-Core.zip",
      checksum: "123817b8959295eeef6a55546b686de86b70c1fa70bc057f031f1a766c9f28a2"
    ),
    .binaryTarget(
      name: "gRPC-C++",
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.50.1/gRPC-C++.zip",
      checksum: "8a13781181d55edcbd6d35218d2129bd13d2369d6c8a1a37ce4a277230e875dc"
    ),
    .binaryTarget(
        name: "BoringSSL-GRPC",
        url: "https://dl.google.com/firebase/ios/bin/grpc/1.44.0/BoringSSL-GRPC.zip",
        checksum: "7ba45f311a17a8b613f96316595f395c76eb7439117f958eba3735caa55e0fd7"
    )
  ]
)
