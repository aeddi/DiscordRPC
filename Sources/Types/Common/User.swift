import Foundation
import AppKit

public class User: Codable {
    public let id: String
    public let username: String
    public let discriminator: String
    public let avatar: String
    public let bot: Bool?
    public let system: Bool?
    public let mfaEnabled: Bool?
    public let locale: String?
    public let verified: Bool?
    public let email: String?
    public let flags: UserFlag?
    public let premiumType: PremiumType?
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

    public func fetchAvatarData(timeout: Int? = 10000) throws -> Data {
        return try fetchUserAvatarData(id: self.id, avatar: self.avatar, timeout: timeout)
    }

    public func fetchAvatarImage(timeout: Int? = 10000) throws -> NSImage {
        return try fetchUserAvatarImage(id: self.id, avatar: self.avatar, timeout: timeout)
    }
}
