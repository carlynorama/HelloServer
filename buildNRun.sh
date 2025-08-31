#!/bin/sh

DEFAULT_CONFIG_VALUE="release"
CONFIGURATION="${1:-$DEFAULT_CONFIG_VALUE}"

mkdir -p HelloWrapper/binary/
cp /Users/$USER/Library/org.swift.swiftpm/swift-sdks/swift-6.1.2-RELEASE_static-linux-0.0.1.artifactbundle/swift-6.1.2-RELEASE_static-linux-0.0.1/swift-linux-musl/musl-1.2.5.sdk/x86_64/usr/libexec/swift/linux-static/swift-backtrace-static HelloWrapper/binary/swift-backtrace

swift build -c $CONFIGURATION --swift-sdk x86_64-swift-linux-musl
cp .build/x86_64-swift-linux-musl/$CONFIGURATION/hello-world HelloWrapper/binary/hello-world

podman build -f HelloWrapper/Containerfile -t wrapped-hello HelloWrapper/
# no -d because want to see errors inline
podman run -p 1234:8080 wrapped-hello