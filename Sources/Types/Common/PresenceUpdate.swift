import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/gateway#presence-update-presence-update-event-fields)
public class PresenceUpdate: Codable {
    /// The user presence is being updated for
    public let user: User
    /// ID of the guild
    public let guildID: String
    /// Either "idle", "dnd", "online", or "offline"
    public let status: PresenceStatus
    /// User's current activities
    public let activities: [Activity]
    /// User's platform-dependent status
    public let clientStatus: [ClientStatus]

    private enum CodingKeys: String, CodingKey {
        case user
        case guildID      = "guild_id"
        case status
        case activities
        case clientStatus = "client_status"
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/gateway#client-status-object)
    public class ClientStatus: Codable {
        /// The user's status set for an active desktop (Windows, Linux, Mac) application session
        public let desktop: PresenceStatus?
        /// The user's status set for an active mobile (iOS, Android) application session
        public let mobile: PresenceStatus?
        /// The user's status set for an active web (browser, bot account) application session
        public let web: PresenceStatus?
    }
}
