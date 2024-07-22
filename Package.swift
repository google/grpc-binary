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
        branch: "nc/firestore-pre_rc1"
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
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.65.1/pre_rc0/grpc.zip",
      checksum: "bd0715d89fb609a29a6c0f273877e698a991e7f1834e2c794fae0808200218c2"
    ),
    .binaryTarget(
      name: "grpcpp",
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.65.1/pre_rc0/grpcpp.zip",
      checksum: "d115d18f2f3a152b91473b9b66972d44f72930829836f8e4bb73e0ea31e63d3e"
    ),
    .binaryTarget(
        name: "openssl_grpc",
        url: "https://dl.google.com/firebase/ios/bin/grpc/1.65.1/pre_rc0/openssl_grpc.zip",
        checksum: "510f9665c5247dbf04211069d1621d2069d80133ffe454e17b30a3db9c18599d"
    )
  ]
)
