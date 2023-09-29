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
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.49.1/gRPC-Core.zip",
      checksum: "cdb31491d57e6d92ac40c81bbb97a65d5f8e61a6d709125fd63c53c700a94d74"
    ),
    .binaryTarget(
      name: "gRPC-C++",
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.49.1/gRPC-C++.zip",
      checksum: "e4a746e5cabee5cc49773b2738ffed0324ad1649f2fb4c3f650370127503c9dc"
    ),
    .binaryTarget(
        name: "BoringSSL-GRPC",
        url: "https://dl.google.com/firebase/ios/bin/grpc/1.44.0/BoringSSL-GRPC.zip",
        checksum: "7ba45f311a17a8b613f96316595f395c76eb7439117f958eba3735caa55e0fd7"
    )
  ]
)
