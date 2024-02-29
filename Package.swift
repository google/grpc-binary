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
      targets: ["grpc-Wrapper"]
    ),
    .library(
      name: "gRPC-C++",
      targets: ["grpcpp-Wrapper"]
    ),
  ],
  dependencies: [
    .package(
        url: "https://github.com/google/abseil-cpp-binary.git",
        "1.2022062300.1" ..< "1.2022062400.0"
    )
  ],
  targets: [
    .target(
      name: "grpc-Wrapper",
      dependencies: ["grpc"],
      path: "grpc-Wrapper",
      resources: [.process("Resources/PrivacyInfo.xcprivacy")]
    ),
    .target(
      name: "openssl-grpc-Wrapper",
      dependencies: ["openssl_grpc"],
      path: "openssl-grpc-Wrapper",
      resources: [.process("Resources/PrivacyInfo.xcprivacy")]
    ),
    .target(
      name: "grpcpp-Wrapper",
      dependencies: [
        "grpcpp",
        "grpc-Wrapper",
        "openssl-grpc-Wrapper",
        .product(name: "abseil", package: "abseil-cpp-binary"),
      ],
      path: "grpcpp-Wrapper",
      resources: [.process("Resources/PrivacyInfo.xcprivacy")]
    ),
    .binaryTarget(
      name: "grpc",
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.49.2/grpc.zip",
      checksum: "99e4a17fd34677622ef2cd99bc742eb079b80219d476544619f6f1583845855e"
    ),
    .binaryTarget(
      name: "grpcpp",
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.49.2/grpcpp.zip",
      checksum: "075ed90f7a09589c1d269b7638dd34e50691b13b203305acb82c6248c1c752e1"
    ),
    .binaryTarget(
        name: "openssl_grpc",
        url: "https://dl.google.com/firebase/ios/bin/grpc/1.49.2/openssl_grpc.zip",
        checksum: "3cb1cf53fb11a82d5f7e9f90a49a0c976535e5c3a89884b86516939f5b3e0871"
    )
  ]
)
