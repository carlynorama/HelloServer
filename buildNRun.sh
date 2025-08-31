#!/bin/sh

DEFAULT_CONFIG_VALUE="release"
CONFIGURATION="${1:-$DEFAULT_CONFIG_VALUE}"

swift build -c $CONFIGURATION --swift-sdk x86_64-swift-linux-musl
mkdir -p HelloWrapper/binary/
cp .build/x86_64-swift-linux-musl/$CONFIGURATION/hello-world HelloWrapper/binary/hello-world

podman build -f HelloWrapper/Containerfile -t wrapped-hello HelloWrapper/
# no -d because want to see errors inline
podman run -p 1234:8080 wrapped-hello