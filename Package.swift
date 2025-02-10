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
      targets: ["grpcWrapper"]
    ),
    .library(
      name: "gRPC-C++",
      targets: ["grpcppWrapper"]
    ),
  ],
  dependencies: [
    .package(
        url: "https://github.com/google/abseil-cpp-binary.git",
        "1.2024072200.0" ..< "1.2024072300.0"
    )
  ],
  targets: [
    .target(
      name: "grpcWrapper",
      dependencies: ["grpc"],
      path: "grpc-Wrapper",
      resources: [.process("Resources/PrivacyInfo.xcprivacy")]
    ),
    .target(
      name: "opensslWrapper",
      dependencies: ["openssl_grpc"],
      path: "openssl-grpc-Wrapper",
      resources: [.process("Resources/PrivacyInfo.xcprivacy")]
    ),
    .target(
      name: "grpcppWrapper",
      dependencies: [
        "grpcpp",
        "grpcWrapper",
        "opensslWrapper",
        .product(name: "abseil", package: "abseil-cpp-binary"),
      ],
      path: "grpcpp-Wrapper",
      resources: [.process("Resources/PrivacyInfo.xcprivacy")]
    ),
    .binaryTarget(
      name: "grpc",
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.69.0/rc0/grpc.zip",
      checksum: "1b9846aba884d0e95d9054646637e2d782d6d1acd7916287ad34fba5ce6b915a"
    ),
    .binaryTarget(
      name: "grpcpp",
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.69.0/rc0/grpcpp.zip",
      checksum: "7f8fcd89a8aef73994a0ffc9a3be2c29f9e49278e1e1b02061a24d1a4c25ed20"
    ),
    .binaryTarget(
        name: "openssl_grpc",
        url: "https://dl.google.com/firebase/ios/bin/grpc/1.69.0/rc0/openssl_grpc.zip",
        checksum: "67b9cc1763686cd6be6ee98b85a51c1140a05a4efc7f0b39da4c4f5a78c4f81c"
    )
  ]
)
