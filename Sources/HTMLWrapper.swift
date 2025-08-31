import Hummingbird

/// Type wrapping HTML code. Will convert to HBResponse that includes the correct
/// content-type header
struct MessageHTML: ResponseGenerator {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var html:String {
        Self.generateHTMLForMessage(message)
    }

    func response(from request: Request, context: some RequestContext) throws -> Response {
        let buffer = ByteBuffer(string: self.html)
        return .init(status: .ok, headers: [.contentType: "text/html"], body: .init(byteBuffer: buffer))
    }

    static func generateHTMLForMessage(_ message:String) -> String {
        """
        <!DOCTYPE html>
        <html>
        <head>
            <title>Hello Little Bird!</title>
            <meta charset="UTF-8">

        </head>
        <body>
        <p>\(message)</p>
        <!-- <p><a href="/">back to index</a>.</p> -->
        </body>
        </html>
        """
    }
}