import Foundation
import AppKit

/// Users in Discord are generally considered the base entity.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/user#user-object-user-structure)
public class User: Codable {
    /// The user's ID (require: `OAuth2Scope.identify`)
    public let id: String
    /// The user's username, not unique across the platform (require: `OAuth2Scope.identify`)
    public let username: String
    /// The user's 4-digit discord-tag (require: `OAuth2Scope.identify`)
    public let discriminator: String
    /// The user's avatar hash (require: `OAuth2Scope.identify`)
    public let avatar: String
    /// Whether the user belongs to an OAuth2 application (require: `OAuth2Scope.identify`)
    public let bot: Bool?
    /// Whether the user is an Official Discord System user (part of the urgent message system) (require: `OAuth2Scope.identify`)
    public let system: Bool?
    /// Whether the user has two factor enabled on their account (require: `OAuth2Scope.identify`)
    public let mfaEnabled: Bool?
    /// The user's chosen language option (require: `OAuth2Scope.identify`)
    public let locale: String?
    /// Whether the email on this account has been verified (require: `OAuth2Scope.email`)
    public let verified: Bool?
    /// The user's email (require: `OAuth2Scope.email`)
    public let email: String?
    /// The flags on a user's account (require: `OAuth2Scope.identify`)
    public let flags: UserFlag?
    /// The type of Nitro subscription on a user's account (require: `OAuth2Scope.identify`)
    public let premiumType: PremiumType?
    /// The public flags on a user's account (require: `OAuth2Scope.identify`)
    public let publicFlags: UserFlag?

    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case discriminator
        case avatar
        case bot
        case system
        case mfaEnabled  = "mfa_enabled"
        case locale
        case verified
        case email
        case flags
        case premiumType = "premium_type"
        case publicFlags = "public_flags"
    }

    public init(
        id: String,
        username: String,
        discriminator: String,
        avatar: String,
        bot: Bool? = nil,
        system: Bool? = nil,
        mfaEnabled: Bool? = nil,
        locale: String? = nil,
        verified: Bool? = nil,
        email: String? = nil,
        flags: UserFlag? = nil,
        premiumType: PremiumType? = nil,
        publicFlags: UserFlag? = nil) {
        self.id = id
        self.username = username
        self.discriminator = discriminator
        self.avatar = avatar
        self.bot = bot
        self.system = system
        self.mfaEnabled = mfaEnabled
        self.locale = locale
        self.verified = verified
        self.email = email
        self.flags = flags
        self.premiumType = premiumType
        self.publicFlags = publicFlags
    }

    public func fetchAvatarData(timeout: Int? = 10000) throws -> Data {
        return try fetchUserAvatarData(id: self.id, avatar: self.avatar, timeout: timeout)
    }

    public func fetchAvatarImage(timeout: Int? = 10000) throws -> NSImage {
        return try fetchUserAvatarImage(id: self.id, avatar: self.avatar, timeout: timeout)
    }
}
