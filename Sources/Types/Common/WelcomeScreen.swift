import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/guild#welcome-screen-object-welcome-screen-structure)
public class WelcomeScreen: Codable {
    /// The server description shown in the welcome screen
    public let description: String?
    /// The channels shown in the welcome screen, up to 5
    public let welcomeChannels: [WelcomeChannel]

    private enum CodingKeys: String, CodingKey {
        case description
        case welcomeChannels = "welcome_channels"
    }

    public class WelcomeChannel: Codable {
        /// The channel's ID
        public let channelID: String
        /// The description shown for the channel
        public let description: String
        /// The emoji ID, if the emoji is custom
        public let emojiID: String?
        /// The emoji name if custom, the unicode character if standard, or null if no emoji is set
        public let emojiName: String?

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case channelID = "channel_id"
            case description
            case emojiID   = "emoji_id"
            case emojiName = "emoji_name"
        }
    }
}
