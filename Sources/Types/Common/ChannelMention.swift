import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#channel-mention-object-channel-mention-structure)
public class ChannelMention: Codable {
    /// ID of the channel
    public let id: String
    /// ID of the guild containing the channel
    public let guildID: String
    /// The [type of channel](https://discord.com/developers/docs/resources/channel#channel-object-channel-types)
    public let type: ChannelType
    /// The name of the channel
    public let name: String

    private enum CodingKeys: String, CodingKey {
        case id
        case guildID = "guild_id"
        case type
        case name
    }
}
