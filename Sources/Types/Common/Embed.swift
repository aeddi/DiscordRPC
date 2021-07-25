import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#embed-object-embed-structure)
public class Embed: Codable {
    /// Title of embed
    public let title: String?
    /// [Type of embed](https://discord.com/developers/docs/resources/channel#embed-object-embed-types) (always "rich" for webhook embeds)
    public let type: EmbedType?
    /// Description of embed
    public let description: String?
    /// Url of embed
    public let url: String?
    /// Timestamp of embed content
    public let timestamp: Date?
    /// Color code of the embed
    public let color: Int?
    /// Footer information
    public let footer: EmbedFooter?
    /// Image information
    public let image: EmbedImage?
    /// Thumbnail information
    public let thumbnail: EmbedThumbnail?
    /// Video information
    public let video: EmbedVideo?
    /// Provider information
    public let provider: EmbedProvider?
    /// Author information
    public let author: EmbedAuthor?
    /// Fields information
    public let fields: [EmbedField]?

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#embed-object-embed-footer-structure)
    public class EmbedFooter: Codable {
        /// Footer text
        public let text: String
        /// URL of footer icon (only supports http(s) and attachments)
        public let iconURL: String?
        /// A proxied url of footer icon
        public let proxyIconURL: String?

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case text
            case iconURL      = "icon_url"
            case proxyIconURL = "proxy_icon_url"
        }
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#embed-object-embed-image-structure)
    public class EmbedImage: Codable {
        /// Source url of image (only supports http(s) and attachments)
        public let url: String?
        /// A proxied url of the image
        public let proxyURL: String?
        /// Height of image
        public let height: Int?
        /// Width of image
        public let width: Int?

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case url
            case proxyURL = "proxy_url"
            case height
            case width
        }
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#embed-object-embed-thumbnail-structure)
    public class EmbedThumbnail: Codable {
        /// Source url of thumbnail (only supports http(s) and attachments)
        public let url: String?
        /// A proxied url of the thumbnail
        public let proxyURL: String?
        /// Height of thumbnail
        public let height: Int?
        /// Width of thumbnail
        public let width: Int?

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case url
            case proxyURL = "proxy_url"
            case height
            case width
        }
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#embed-object-embed-video-structure)
    public class EmbedVideo: Codable {
        /// Source url of video
        public let url: String?
        /// A proxied url of the video
        public let proxyURL: String?
        /// Height of video
        public let height: Int?
        /// Width of video
        public let width: Int?

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case url
            case proxyURL = "proxy_url"
            case height
            case width
        }
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#embed-object-embed-provider-structure)
    public class EmbedProvider: Codable {
        /// Name of provider
        public let name: String?
        /// URL of provider
        public let url: String?
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#embed-object-embed-author-structure)
    public class EmbedAuthor: Codable {
        ///    string    name of author
        public let name: String?
        ///     string    url of author
        public let url: String?
        ///     string    url of author icon (only supports http(s) and attachments)
        public let iconURL: String?
        /// A proxied url of author icon
        public let proxyIconURL: String?

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case name
            case url
            case iconURL      = "icon_url"
            case proxyIconURL = "proxy_icon_url"
        }
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#embed-object-embed-field-structure)
    public class EmbedField: Codable {
        /// Name of the field
        public let name: String
        /// Value of the field
        public let value: String
        /// Whether or not this field should display inline
        public let inline: Bool?
    }
}
