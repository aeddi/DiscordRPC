import Foundation

public class Guild: Codable {
    public let id: String
    public let name: String
    public let icon: String?
    public let iconHash: String?
    public let splash: String?
    public let discoverySplash: String?
    public let owner: Bool?
    public let ownerID: String?
    public let permissions: String?
    public let region: String?
    public let afkChannelID: String?
    public let afkTimeout: Int?
    public let widgetEnabled: Bool?
    public let widgetChannelID: String?
    public let verificationLevel: Int?
    public let defaultMessageNotifications: Int?
    public let explicitContentFilter: Int?
    public let roles: [Role]?
    public let emojis: [Emoji]?
    public let features: [GuildFeature]?
    public let mfaLevel: Int?
    public let applicationID: String?
    public let systemChannelID: String?
    public let systemChannelFlags: Int?
    public let rulesChannelID: String?
    public let joinedAt: Date?
    public let large: Bool?
    public let unavailable: Bool?
    public let memberCount: Int?
    public let voiceStates: [VoiceState]?
    public let members: [GuildMember]?
    public let channels: [Channel]?
    public let threads: [Channel]?
    public let presences: [Presence]?
    public let maxPresences: Int?
    public let maxMembers: Int?
    public let vanityUrlCode: String?
    public let description: String?
    public let banner: String?
    public let premiumTier: Int?
    public let premiumSubscriptionCount: Int?
    public let preferredLocale: String?
    public let publicUpdatesChannelID: String?
    public let maxVideoChannelUsers: Int?
    public let approximateMemberCount: Int?
    public let approximatePresenceCount: Int?
    public let welcomeScreen: WelcomeScreen?
    public let nsfwLevel: Int?
    public let stageInstances: [StageInstance]?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case icon
        case iconHash                    = "icon_hash"
        case splash
        case discoverySplash             = "discovery_splash"
        case owner
        case ownerID                     = "owner_id"
        case permissions
        case region
        case afkChannelID                = "afk_channel_id"
        case afkTimeout                  = "afk_timeout"
        case widgetEnabled               = "widget_enabled"
        case widgetChannelID             = "widget_channel_id"
        case verificationLevel           = "verification_level"
        case defaultMessageNotifications = "default_message_notifications"
        case explicitContentFilter       = "explicit_content_filter"
        case roles
        case emojis
        case features
        case mfaLevel                    = "mfa_level"
        case applicationID               = "application_id"
        case systemChannelID             = "system_channel_id"
        case systemChannelFlags          = "system_channel_flags"
        case rulesChannelID              = "rules_channel_id"
        case joinedAt                    = "joined_at"
        case large
        case unavailable
        case memberCount                 = "member_count"
        case voiceStates                 = "voice_states"
        case members
        case channels
        case threads
        case presences
        case maxPresences                = "max_presences"
        case maxMembers                  = "max_members"
        case vanityUrlCode               = "vanity_url_code"
        case description
        case banner
        case premiumTier                 = "premium_tier"
        case premiumSubscriptionCount    = "premium_subscription_count"
        case preferredLocale             = "preferred_locale"
        case publicUpdatesChannelID      = "public_updates_channel_id"
        case maxVideoChannelUsers        = "max_video_channel_users"
        case approximateMemberCount      = "approximate_member_count"
        case approximatePresenceCount    = "approximate_presence_count"
        case welcomeScreen               = "welcome_screen"
        case nsfwLevel                   = "nsfw_level"
        case stageInstances              = "stage_instances"
    }
}
