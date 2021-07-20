import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#attachment-object-attachment-structure)
public class Attachment: Codable {
    /// Attachment ID
    public let id: String
    /// Name of file attached
    public let filename: String
    /// The attachment's [media type](https://en.wikipedia.org/wiki/Media_type)
    public let contentType: String?
    /// Size of file in bytes
    public let size: Int
    /// Source url of file
    public let url: String
    /// A proxied url of file
    public let proxyURL: String
    /// Height of file (if image)
    public let height: Int?
    /// Width of file (if image)
    public let width: Int?

    private enum CodingKeys: String, CodingKey {
        case id
        case filename
        case contentType = "content_type"
        case size
        case url
        case proxyURL    = "proxy_url"
        case height
        case width
    }
}
