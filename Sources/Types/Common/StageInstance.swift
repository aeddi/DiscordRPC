import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/stage-instance#stage-instance-object-stage-instance-structure)
public class StageInstance: Codable {
    /// The ID of this Stage instance
    public let id: String
    /// The guild ID of the associated Stage channel
    public let guildID: String
    /// The ID of the associated Stage channel
    public let channelID: String
    /// The topic of the Stage instance (1-120 characters)
    public let topic: String
    /// The privacy level of the Stage instance
    public let privacyLevel: PrivacyLevel
    /// Whether or not Stage discovery is disabled
    public let discoverableDisabled: Bool

    private enum CodingKeys: String, CodingKey {
        case id
        case guildID              = "guild_id"
        case channelID            = "channel_id"
        case topic
        case privacyLevel         = "privacy_level"
        case discoverableDisabled = "discoverable_disabled"
    }
}
