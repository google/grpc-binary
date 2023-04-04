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
        // TODO(ncooke3): Figure out versioning stratgey for binary Abseil releases.
        // BEFORE: "0.20220623.0"..<"0.20220624.0"
        .exact("10.8.0-rc.1")
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
      // TODO(ncooke3): Update the `url` with the actual value.
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.44.0-grpc/gRPC-Core.zip",
      // TODO(ncooke3): Update the `checksum` with the actual value.
      checksum: "7135a5ff1a8c94b7edade3dcbfdcfaabf16435ecd32d4319bdff54c0403a6bbc"
    ),
    .binaryTarget(
      name: "gRPC-C++",
      // TODO(ncooke3): Update the `url` with the actual value.
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.44.0-grpc/gRPC-C++.zip",
      // TODO(ncooke3): Update the `checksum` with the actual value.
      checksum: "1bd71106e72d57209e3fd74c7998e1f09f235d4ed6455e135ea8885acd41955c"
    ),
    .binaryTarget(
        name: "BoringSSL-GRPC",
        // TODO(ncooke3): Decide on versioning strategy for BoringSSL-gRPC.
        url: "https://dl.google.com/firebase/ios/bin/grpc/1.44.0-grpc/BoringSSL-GRPC.zip",
        checksum: "3ce9cc692877c8802c00edc8f6994a4a305f416634a62c38844c8b8809343ced"
    )
  ]
)
