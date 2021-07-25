import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/guild#guild-member-object-guild-member-structure)
public class GuildMember: Codable {
    /// The user this guild member represents
    public let user: User?
    /// This users guild nickname
    public let nick: String?
    /// Array of role object IDs
    public let roles: [String]
    /// When the user joined the guild
    public let joinedAt: Date
    /// When the user started boosting the guild
    public let premiumSince: Date?
    /// Whether the user is deafened in voice channels
    public let deaf: Bool
    /// Whether the user is muted in voice channels
    public let mute: Bool
    /// Whether the user has not yet passed the guild's Membership Screening requirements
    public let pending: Bool?
    /// Total permissions of the member in the channel, including overwrites, returned when in the interaction object
    public let permissions: String?

    private enum CodingKeys: String, CodingKey {
        case user
        case nick
        case roles
        case joinedAt     = "joined_at"
        case premiumSince = "premium_since"
        case deaf
        case mute
        case pending
        case permissions
    }
}
