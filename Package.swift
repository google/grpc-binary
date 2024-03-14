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
        "1.2024011601.0" ..< "1.2024011700.0"
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
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.62.1/rc1/grpc.zip",
      checksum: "df72e1d79ee5f938a63e261ab58c70e907b95a8b42147aa155c35b43df1dd696"
    ),
    .binaryTarget(
      name: "grpcpp",
      url: "https://dl.google.com/firebase/ios/bin/grpc/1.62.1/rc1/grpcpp.zip",
      checksum: "8075379cb5ab3fb84afca729e215b2503f20648e17d960a9fe013812156a42e0"
    ),
    .binaryTarget(
        name: "openssl_grpc",
        url: "https://dl.google.com/firebase/ios/bin/grpc/1.62.1/rc1/openssl_grpc.zip",
        checksum: "a24441fe024e19e135b999a5cfbf5a7322d2dac8840e9ba5a47272cf3e9d842c"
    )
  ]
)
