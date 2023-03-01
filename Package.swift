// swift-tools-version:5.3

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
    // TODO(ncooke3): Figure out versioning stratgey for binary Abseil releases.
    .package(
      url: "https://github.com/google/abseil-cpp-binary.git", "0.20220623.0"..<"0.20220624.0"),
    // TODO(ncooke3): Figure out versioning stratgey for binary BoringSSL releases.
    .package(url: "https://github.com/google/boringssl-binary.git", "0.9.0"..<"0.10.0"),
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
        .product(name: "abseil", package: "abseil-cpp-binary"),
        .product(name: "BoringSSL-GRPC", package: "boringssl-binary"),
      ],
      path: "gRPC-CXX-Wrapper"
    ),
    .binaryTarget(
      name: "gRPC-Core",
      // TODO(ncooke3): Update the `url` with the actual value.
      url: "URL_TO_BINARY",
      // TODO(ncooke3): Update the `checksum` with the actual value.
      checksum: "CHECKSUM"
    ),
    .binaryTarget(
      name: "gRPC-C++",
      // TODO(ncooke3): Update the `url` with the actual value.
      url: "URL_TO_BINARY",
      // TODO(ncooke3): Update the `checksum` with the actual value.
      checksum: "CHECKSUM"
    ),
  ]
)
