import Foundation

/// Guilds in Discord represent an isolated collection of users and channels, and are often referred to as "servers" in the UI.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/guild#guild-object-guild-structure)
public class Guild: Codable {
    /// Guild ID
    public let id: String
    /// Guild name (2-100 characters, excluding trailing and leading whitespace)
    public let name: String
    /// [Icon hash](https://discord.com/developers/docs/reference#image-formatting)
    public let icon: String?
    /// [Icon hash](https://discord.com/developers/docs/reference#image-formatting), returned when in the template object
    public let iconHash: String?
    /// [Splash hash](https://discord.com/developers/docs/reference#image-formatting)
    public let splash: String?
    /// [Discovery splash hash](https://discord.com/developers/docs/reference#image-formatting); only present for guilds with the "DISCOVERABLE" feature
    public let discoverySplash: String?
    /// True if [the user](https://discord.com/developers/docs/resources/user#get-current-user-guilds) is the owner of the guild
    public let owner: Bool?
    /// ID of owner
    public let ownerID: String?
    /// Total permissions for the user in the guild (excludes overwrites)
    public let permissions: String?
    /// [Voice region](https://discord.com/developers/docs/resources/voice#voice-region-object) ID for the guild (deprecated)
    public let region: String?
    /// ID of afk channel
    public let afkChannelID: String?
    /// AFK timeout in seconds
    public let afkTimeout: Int?
    /// True if the server widget is enabled
    public let widgetEnabled: Bool?
    /// The channel ID that the widget will generate an invite to, or null if set to no invite
    public let widgetChannelID: String?
    /// [Verification level](https://discord.com/developers/docs/resources/guild#guild-object-verification-level) required for the guild
    public let verificationLevel: VerificationLevel?
    /// Default [message notifications level](https://discord.com/developers/docs/resources/guild#guild-object-default-message-notification-level)
    public let defaultMessageNotifications: DefaultMessageNotificationLevel?
    /// [Explicit content filter level](https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level)
    public let explicitContentFilter: ExplicitContentFilterLevel?
    /// Roles in the guild
    public let roles: [Role]?
    /// Custom guild emojis
    public let emojis: [Emoji]?
    /// Enabled guild features
    public let features: [GuildFeature]?
    /// Required [MFA level](https://discord.com/developers/docs/resources/guild#guild-object-mfa-level) for the guild
    public let mfaLevel: MFALevel?
    /// Application ID of the guild creator if it is bot-created
    public let applicationID: String?
    /// The ID of the channel where guild notices such as welcome messages and boost events are posted
    public let systemChannelID: String?
    /// [System channel flags](https://discord.com/developers/docs/resources/guild#guild-object-system-channel-flags)
    public let systemChannelFlags: SystemChannelFlags?
    /// The ID of the channel where Community guilds can display rules and/or guidelines
    public let rulesChannelID: String?
    /// When this guild was joined at
    public let joinedAt: Date?
    /// True if this is considered a large guild
    public let large: Bool?
    /// True if this guild is unavailable due to an outage
    public let unavailable: Bool?
    /// Total number of members in this guild
    public let memberCount: Int?
    /// States of members currently in voice channels; lacks the `guild_id` key
    public let voiceStates: [VoiceState]?
    /// Users in the guild
    public let members: [GuildMember]?
    /// Channels in the guild
    public let channels: [Channel]?
    /// All active threads in the guild that current user has permission to view
    public let threads: [Channel]?
    /// Presences of the members in the guild, will only include non-offline members if the size is greater than `large threshold`.
    public let presences: [PresenceUpdate]?
    /// The maximum number of presences for the guild (`null` is always returned, apart from the largest of guilds)
    public let maxPresences: Int?
    /// The maximum number of members for the guild
    public let maxMembers: Int?
    /// The vanity url code for the guild
    public let vanityUrlCode: String?
    /// The description of a Community guild
    public let description: String?
    /// [Banner hash](https://discord.com/developers/docs/reference#image-formatting)
    public let banner: String?
    /// [Premium tier](https://discord.com/developers/docs/resources/guild#guild-object-premium-tier) (Server Boost level)
    public let premiumTier: PremiumTier?
    /// The number of boosts this guild currently has
    public let premiumSubscriptionCount: Int?
    /// The preferred locale of a Community guild; used in server discovery and notices from Discord; defaults to "en-US"
    public let preferredLocale: String?
    /// The ID of the channel where admins and moderators of Community guilds receive notices from Discord
    public let publicUpdatesChannelID: String?
    /// The maximum amount of users in a video channel
    public let maxVideoChannelUsers: Int?
    /// Approximate number of members in this guild, returned from the `GET /guilds/<id>` endpoint when `with_counts` is `true`
    public let approximateMemberCount: Int?
    /// Approximate number of non-offline members in this guild, returned from the `GET /guilds/<id>` endpoint when `with_counts` is `true`
    public let approximatePresenceCount: Int?
    /// The welcome screen of a Community guild, shown to new members, returned in an [Invite](https://discord.com/developers/docs/resources/invite#invite-object)'s guild object
    public let welcomeScreen: WelcomeScreen?
    /// [Guild NSFW level](https://discord.com/developers/docs/resources/guild#guild-object-guild-nsfw-level)
    public let nsfwLevel: GuildNSFWLevel?
    /// stage instances in the guild
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
