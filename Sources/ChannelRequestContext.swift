import Hummingbird
import NIOCore

struct ChannelRequestContext: RequestContext {
    var coreContext: CoreRequestContextStorage
    let channel: Channel


    init(source: Source) {
        self.coreContext = .init(source: source)
        self.channel = source.channel
    }


    /// Extract Remote IP from Channel
    var remoteAddress: SocketAddress? { self.channel.remoteAddress }
}