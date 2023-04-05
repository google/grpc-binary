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
        "1.2021110200.0" ..< "1.2021110300.0"
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
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.44.0/gRPC-Core.zip",
      checksum: "6c8ae417ea4caf6252c8c68ca7092cb11d12436501727a24a01a8371336c2bd0"
    ),
    .binaryTarget(
      name: "gRPC-C++",
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.44.0/gRPC-C++.zip",
      checksum: "c1f167f54b4715d71b5e2c80476b7bf0b58cc8e21633a1f267df339e796d3cca"
    ),
    .binaryTarget(
        name: "BoringSSL-GRPC",
        url: "https://dl.google.com/firebase/ios/bin/grpc/1.44.0/BoringSSL-GRPC.zip",
        checksum: "7ba45f311a17a8b613f96316595f395c76eb7439117f958eba3735caa55e0fd7"
    )
  ]
)
