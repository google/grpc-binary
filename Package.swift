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
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.69.1/rc0/grpc.zip",
      checksum: "61bb6e29798cdc6898d7fcdf2d6a5e5191524dea4ece59d582329a1a56ebbfb3"
    ),
    .binaryTarget(
      name: "grpcpp",
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.69.1/rc0/grpcpp.zip",
      checksum: "c965a70fc06c1323d631d909168ba801fb783df964e3625ca922250dd625b197"
    ),
    .binaryTarget(
        name: "openssl_grpc",
        url: "https://dl.google.com/firebase/ios/bin/grpc/1.69.1/rc0/openssl_grpc.zip",
        checksum: "52494719d0dda77fa9a65c62207f22814c7799d522b4ae73d1244dbe61cf2b89"
    )
  ]
)
