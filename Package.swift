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
        branch: "ncooke3-patch-2",
        // "1.2024011601.1" ..< "1.2024011700.0"
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
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.65.0/pre_rc0/grpc.zip",
      checksum: "3c3f03e05a0256f6f995f80e949d883cf0f82e1c3c790822940f1fc2e2d77940"
    ),
    .binaryTarget(
      name: "grpcpp",
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.65.0/pre_rc0/grpcpp.zip",
      checksum: "2d160a16d3f6b53ab4df5798dd6a653ce4be8cdadb734251cca001f6a8f5b289"
    ),
    .binaryTarget(
        name: "openssl_grpc",
        url: "https://dl.google.com/firebase/ios/bin/grpc/1.65.0/pre_rc0/openssl_grpc.zip",
        checksum: "5228743f84cd54d018bea323dbc7bb0459a2b88a3802cfb4d70bc7114b360c20"
    )
  ]
)
