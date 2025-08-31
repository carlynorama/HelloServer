# Basic Containerizable Server

https://doineedkubernetes.com 

## Resources
### Overviews

- https://github.com/apple/swift-container-plugin
    - https://swiftpackageindex.com/apple/swift-container-plugin/1.0.2/documentation/swift-container-plugin 
    - [How to put Swift in a box](https://fosdem.org/2025/schedule/event/fosdem-2025-5116-how-to-put-swift-in-a-box-building-container-images-with-swift-container-plugin/) at [FOSDEM 2025](https://fosdem.org/2025/schedule/track/swift/).
    - [Swift to the cloud in a single step](https://www.youtube.com/watch?v=9AaINsCfZzw) at [ServerSide.Swift 2024](https://www.serversideswift.info/2024/speakers/euan-harris/).

### Set up Static Compiling

- https://www.swift.org/documentation/articles/static-linux-getting-started.html
- https://github.com/swiftlang/swift-docker/tree/main/swift-ci/sdks/static-linux
- https://github.com/swiftlang/swift-evolution/blob/main/proposals/0387-cross-compilation-destinations.md


### Set up a Registry


swift build --configuration release --swift-sdk x86_64-swift-linux-musl

  685  cd CrossCompileTester
  686  swift build -v --swift-sdk x86_64-swift-linux-musl
  687  scp .build/x86_64-swift-linux-musl/debug/cctest carlynorama@tilde.crashspace.org:~/cctest
  688  file .build/x86_64-swift-linux-musl/debug/cctest
  689  ssh carlynorama@tilde.crashspace.org ~/cctest
  690  ssh carlynorama@tilde.crashspace.org


https://github.com/swiftlang/swift/blob/main/docs/Backtracing.rst
https://github.com/vapor/template/blob/dd27d05537c434572c7f90ce6bd22d5960a27442/Dockerfile#L40
https://github.com/Cyberbeni/MultiArchSwiftDockerfileExample/blob/650fe354e4b40e827e412bd48521833a643175ea/Dockerfile


https://forums.swift.org/t/de-minimis-server-containerfile-for-a-musl-based-static-linking/81887/7
About the SWIFT_BACKTRACE env:

If you aren’t using a statically compiled binary, it’ll just work.

However, for statically-linked binaries, backtracing isn’t available in the binary, so like in the Vapor template’s Dockerfile, you need to manually copy the backtrace binary over. That has been a relatively long-standing issue for a few years, and AFAIK the Swift team would want to resolve that eventually.

If you’re not putting the backtrace binary in a default location that the Swift runtime will check, you’ll also need to use the env var to mention where the backtrace binary is. In SWIFT_BACKTRACE=enable=yes,...,swift-backtrace=./swift-backtrace-static, the last key value is specifying the place where the binary can be found: swift-backtrace=./swift-backtrace-static (relative to the executable).

There are some Backtracing docs in the Swift repo if you’re curious about it.

I’d say having backtracing working is pretty important so a user has something to work with if a crash happens.



https://forums.swift.org/t/unable-to-generate-a-backtrace-using-swift-6-static-linux-sdk/74215



2025-08-31T00:02:32+0000 info HelloWorldHummingbird: hb.request.id=71972d586ed45c15ae777a6b65f1c89c hb.request.method=GET hb.request.path=/crashme [Hummingbird] Request
swift-runtime: failed to suspend thread 2 while processing a crash; backtraces will be missing information
swift-runtime: failed to suspend thread 2 while processing a crash; backtraces will be missing information

*** Signal 4: Backtracing from 0xed4f79... failed ***

qemu: uncaught target signal 4 (Illegal instruction) - core dumped


797c5f81511bb6d52f1c35ffb1aa5ba7c2bc6d16f8430b93d566663aa57354cd
2025-08-31T00:04:53+0000 info HelloWorldHummingbird: [HummingbirdCore] Server started and listening on 0.0.0.0:8080
2025-08-31T00:05:06+0000 info HelloWorldHummingbird: hb.request.id=9590a31044520e36e2a8ba4dea357f82 hb.request.method=GET hb.request.path=/ [Hummingbird] Request
2025-08-31T00:05:12+0000 info HelloWorldHummingbird: hb.request.id=9590a31044520e36e2a8ba4dea357f83 hb.request.method=GET hb.request.path=/crashme [Hummingbird] Request
hello_world/Application+build.swift:22: Fatal error: Whoops
swift-runtime: failed to suspend thread 2 while processing a crash; backtraces will be missing information
swift-runtime: failed to suspend thread 2 while processing a crash; backtraces will be missing information

*** Signal 4: Backtracing from 0x255b6aa... failed ***

qemu: uncaught target signal 4 (Illegal instruction) - core dumped