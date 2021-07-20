import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/emoji#emoji-object-emoji-structure)
public class Emoji: Codable {
    /// Emoji ID
    public let id: String?
    /// Emoji name
    public let name: String?
    /// Roles allowed to use this emoji
    public let roles: [Role]?
    /// User that created this emoji
    public let user: User?
    /// Whether this emoji must be wrapped in colons
    public let requireColons: Bool?
    /// Whether this emoji is managed
    public let managed: Bool?
    /// Whether this emoji is animated
    public let animated: Bool?
    /// Whether this emoji can be used, may be false due to loss of Server Boosts
    public let available: Bool?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case roles
        case user
        case requireColons = "require_colons"
        case managed
        case animated
        case available
    }

    public init(
        id: String? = nil,
        name: String? = nil,
        roles: [Role]? = nil,
        user: User? = nil,
        requireColons: Bool? = nil,
        managed: Bool? = nil,
        animated: Bool? = nil,
        available: Bool? = nil) {
        self.id = id
        self.name = name
        self.roles = roles
        self.user = user
        self.requireColons = requireColons
        self.managed = managed
        self.animated = animated
        self.available = available
    }
}
