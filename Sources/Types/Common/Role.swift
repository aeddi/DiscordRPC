import Foundation

/// Roles represent a set of permissions attached to a group of users.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/permissions#role-object-role-structure)
public class Role: Codable {
    /// Role ID
    public let id: String
    /// Role name
    public let name: String
    /// Integer representation of hexadecimal color code
    public let color: Int
    /// if this role is pinned in the user listing
    public let hoist: Bool
    /// Position of this role
    public let position: Int
    /// Permission bit set
    public let permissions: String
    /// Whether this role is managed by an integration
    public let managed: Bool
    /// Whether this role is mentionable
    public let mentionable: Bool
    /// The tags this role has
    public let tags: RoleTags?

    public init(
        id: String,
        name: String,
        color: Int,
        hoist: Bool,
        position: Int,
        permissions: String,
        managed: Bool,
        mentionable: Bool,
        tags: Role.RoleTags? = nil)
    {
        self.id = id
        self.name = name
        self.color = color
        self.hoist = hoist
        self.position = position
        self.permissions = permissions
        self.managed = managed
        self.mentionable = mentionable
        self.tags = tags
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/permissions#role-object-role-tags-structure)
    public class RoleTags: Codable {
        /// The ID of the bot this role belongs to
        public let botID: String?
        /// The ID of the integration this role belongs to
        public let integrationID: String?
        /// Whether this is the guild's premium subscriber role
        public let premiumSubscriber: Bool?

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case botID             = "bot_id"
            case integrationID     = "integration_id"
            case premiumSubscriber = "premium_subscriber"
        }

        public init(
            botID: String? = nil,
            integrationID: String? = nil,
            premiumSubscriber: Bool? = nil)
        {
            self.botID = botID
            self.integrationID = integrationID
            self.premiumSubscriber = premiumSubscriber
        }
    }
}
