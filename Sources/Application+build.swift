//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftContainerPlugin open source project
//
// Copyright (c) 2025 Apple Inc. and the SwiftContainerPlugin project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftContainerPlugin project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import Foundation
import Hummingbird
import Logging

typealias AppRequestContext = ChannelRequestContext
let myos = ProcessInfo.processInfo.operatingSystemVersionString

// func crashMe() -> String {
//     preconditionFailure("Whoops")
// }

func buildApplication(configuration: ApplicationConfiguration) -> some ApplicationProtocol {
    
    let router = buildRouter()

    let app = Application(
        router: router,
        configuration: configuration,
        logger: Logger(label: "HelloServer")
    )

    return app
}


func buildRouter() -> Router<AppRequestContext> {
    let router = Router(context: AppRequestContext.self) 
    router.addMiddleware { LogRequestsMiddleware(.info) }
    router.get("/") { _, context in
        guard let ip = context.remoteAddress else { throw HTTPError(.badRequest) }
        return MessageHTML("Hello \(ip), from Hummingbird on \(myos)\n")
    }
    // router.get("/crashme") {  _, _ in
    //     crashMe()
    // }


    return router

}