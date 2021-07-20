/// Enum of all the OAuth2 scopes that Discord supports.
/// - SeeAlso: [Discord Reference](https://github.com/davfsa/discord-api-docs/blob/4013288bebb5748ec701c94c52164af9b29c66d5/docs/topics/OAuth2.md#oauth2-scopes)
public enum OAuth2Scope: String, Codable {
    /// Allows your app to fetch data from a user's "Now Playing/Recently Played" list - requires Discord approval.
    case activitiesRead             = "activities.read"
    /// Allows your app to update a user's activity - requires Discord approval (NOT REQUIRED FOR [GAMESDK ACTIVITY MANAGER](https://github.com/davfsa/discord-api-docs/blob/4013288bebb5748ec701c94c52164af9b29c66d5/docs/topics/OAuth2.md#DOCS_GAME_SDK_ACTIVITIES/)).
    case activitiesWrite            = "activities.write"
    /// Allows your app to read build data for a user's applications.
    case applicationsBuildsRead     = "applications.builds.read"
    /// Allows your app to upload/update builds for a user's applications - requires Discord approval.
    case applicationsBuildsUpload   = "applications.builds.upload"
    /// Allows your app to use [Slash Commands](https://github.com/davfsa/discord-api-docs/blob/4013288bebb5748ec701c94c52164af9b29c66d5/docs/topics/OAuth2.md#DOCS_INTERACTIONS_SLASH_COMMANDS/) in a guild.
    case applicationsCommands       = "applications.commands"
    /// Allows your app to update its [Slash Commands](https://github.com/davfsa/discord-api-docs/blob/4013288bebb5748ec701c94c52164af9b29c66d5/docs/topics/OAuth2.md#DOCS_INTERACTIONS_SLASH_COMMANDS/) via this bearer token - [client credentials grant only](https://github.com/davfsa/discord-api-docs/blob/4013288bebb5748ec701c94c52164af9b29c66d5/docs/topics/OAuth2.md#DOCS_TOPICS_OAUTH2/client-credentials-grant).
    case applicationsCommandsUpdate = "applications.commands.update"
    /// Allows your app to read entitlements for a user's applications.
    case applicationsEntitlements   = "applications.entitlements"
    /// Allows your app to read and update store data (SKUs, store listings, achievements, etc.) for a user's applications.
    case applicationsStoreUpdate    = "applications.store.update"
    /// For oauth2 bots, this puts the bot in the user's selected guild by default.
    case bot                        = "bot"
    /// Allows [/users/@me/connections](https://github.com/davfsa/discord-api-docs/blob/4013288bebb5748ec701c94c52164af9b29c66d5/docs/topics/OAuth2.md#DOCS_RESOURCES_USER/get-user-connections) to return linked third-party accounts.
    case connections                = "connections"
    /// Enables [/users/@me](https://github.com/davfsa/discord-api-docs/blob/4013288bebb5748ec701c94c52164af9b29c66d5/docs/topics/OAuth2.md#DOCS_RESOURCES_USER/get-current-user) to return an `email`.
    case email                      = "email"
    /// Allows your app to [join users to a group dm](https://github.com/davfsa/discord-api-docs/blob/4013288bebb5748ec701c94c52164af9b29c66d5/docs/topics/OAuth2.md#DOCS_RESOURCES_CHANNEL/group-dm-add-recipient).
    case gdmJoin                    = "gdm.join"
    /// Allows [/users/@me/guilds](https://github.com/davfsa/discord-api-docs/blob/4013288bebb5748ec701c94c52164af9b29c66d5/docs/topics/OAuth2.md#DOCS_RESOURCES_USER/get-current-user-guilds) to return basic information about all of a user's guilds.
    case guilds                     = "guilds"
    /// Allows [/guilds/{guild.id}/members/{user.id}](https://github.com/davfsa/discord-api-docs/blob/4013288bebb5748ec701c94c52164af9b29c66d5/docs/topics/OAuth2.md#DOCS_RESOURCES_GUILD/add-guild-member) to be used for joining users to a guild.
    case guildsJoin                 = "guilds.join"
    /// Allows [/users/@me](https://github.com/davfsa/discord-api-docs/blob/4013288bebb5748ec701c94c52164af9b29c66d5/docs/topics/OAuth2.md#DOCS_RESOURCES_USER/get-current-user) without `email`.
    case identify                   = "identify"
    /// For local rpc server api access, this allows you to read messages from all client channels (otherwise restricted to channels/guilds your app creates).
    case messagesRead               = "messages.read"
    /// Allows your app to know a user's friends and implicit relationships - requires Discord approval.
    case relationshipsRead          = "relationships.read"
    /// For local rpc server access, this allows you to control a user's local Discord client - requires Discord approval.
    case rpc                        = "rpc"
    /// For local rpc server access, this allows you to update a user's activity - requires Discord approval.
    case rpcActivitiesWrite         = "rpc.activities.write"
    /// For local rpc server access, this allows you to receive notifications pushed out to the user - requires Discord approval.
    case rpcNotificationsRead       = "rpc.notifications.read"
    /// For local rpc server access, this allows you to read a user's voice settings and listen for voice events - requires Discord approval.
    case rpcVoiceRead               = "rpc.voice.read"
    /// For local rpc server access, this allows you to update a user's voice settings - requires Discord approval.
    case rpcVoiceWrite              = "rpc.voice.write"
    /// This generates a webhook that is returned in the oauth token response for authorization code grants.
    case webhookIncoming            = "webhook.incoming"
}

/// Enum of all the error codes that can be returned by the Discord RPC API when a command failed.
/// - SeeAlso: [Discord Reference](https://github.com/discord/discord-api-docs/blob/8ed15ce2a11beab51918a084cfd5450ea7a3a211/docs/topics/Opcodes_and_Status_Codes.md#rpc-error-codes)
public enum ErrorCode: Int, Codable {
    /// An unknown error occurred.
    case unknownError                    = 1000
    /// You sent an invalid payload.
    case invalidPayload                  = 4000
    /// Invalid command name specified.
    case invalidCommand                  = 4002
    /// Invalid guild ID specified.
    case invalidGuild                    = 4003
    /// Invalid event name specified.
    case invalidEvent                    = 4004
    /// Invalid channel ID specified.
    case invalidChannel                  = 4005
    /// You lack permissions to access the given resource.
    case invalidPermissions              = 4006
    /// An invalid OAuth2 application ID was used to authorize or authenticate with.
    case invalidClientID                 = 4007
    /// An invalid OAuth2 application origin was used to authorize or authenticate with.
    case invalidOrigin                   = 4008
    /// An invalid OAuth2 token was used to authorize or authenticate with.
    case invalidToken                    = 4009
    /// The specified user ID was invalid.
    case invalidUser                     = 4010
    /// A standard OAuth2 error occurred; check the data object for the OAuth2 error details.
    case oAuth2Error                     = 5000
    /// An asynchronous `DiscordRPC.selectTextChannelAsync(channelID:,timeout:)` / `DiscordRPC.selectVoiceChannelAsync(channelID:,timeout:,force:)` command timed out.
    case selectChannelTimedOut           = 5001
    /// An asynchronous `DiscordRPC.getGuildAsync(guildID:,timeout:) `command timed out.
    case getGuildTimedOut                = 5002
    /// You tried to join a user to a voice channel but the user was already in one.
    case selectVoiceForceRequired        = 5003
    /// You tried to capture more than one shortcut key at once.
    case captureShortcutAlreadyListening = 5004
}

/// Enum of all the error codes that can be returned by the Discord RPC API when a disconnection occured.
/// - SeeAlso: [Discord Reference](https://github.com/discord/discord-api-docs/blob/8ed15ce2a11beab51918a084cfd5450ea7a3a211/docs/topics/Opcodes_and_Status_Codes.md#rpc-close-event-codes)
public enum CloseEventCode: Int, Codable {
    /// You connected to the RPC server with an invalid client ID.
    case invalidClientID   = 4000
    /// You connected to the RPC server with an invalid origin.
    case invalidOrigin     = 4001
    /// You are being rate limited.
    case rateLimited       = 4002
    /// The OAuth2 token associated with a connection was revoked, get a new one!
    case tokenRevoked      = 4003
    /// The RPC Server version specified in the connection string was not valid.
    case invalidVersion    = 4004
    /// The encoding specified in the connection string was not valid.
    case invalidEncoding   = 4005

    /// Not in Discord API, added to notify user whenever a disconnection occurs.
    case socketDisconnected = 0
}

/// Enum of all the command types that can be used with the Discord RPC API.
/// - SeeAlso: [Discord Reference](https://github.com/discord/discord-api-docs/blob/8ed15ce2a11beab51918a084cfd5450ea7a3a211/docs/topics/RPC.md#rpc-commands)
public enum CommandType: String, Codable {
    /// Event dispatch.
    case dispatch                = "DISPATCH"
    /// Used to authorize a new client with your app.
    case authorize               = "AUTHORIZE"
    /// Used to authenticate an existing client with your app.
    case authenticate            = "AUTHENTICATE"
    /// Used to retrieve guild information from the client.
    case getGuild                = "GET_GUILD"
    /// Used to retrieve a list of guilds from the client.
    case getGuilds               = "GET_GUILDS"
    /// Used to retrieve channel information from the client.
    case getChannel              = "GET_CHANNEL"
    /// Used to retrieve a list of channels for a guild from the client.
    case getChannels             = "GET_CHANNELS"
    /// Used to subscribe to an RPC event.
    case subscribe               = "SUBSCRIBE"
    /// Used to unsubscribe from an RPC event.
    case unsubscribe             = "UNSUBSCRIBE"
    /// Used to change voice settings of users in voice channels.
    case setUserVoiceSettings    = "SET_USER_VOICE_SETTINGS"
    /// Used to join or leave a voice channel, group dm, or dm.
    case selectVoiceChannel      = "SELECT_VOICE_CHANNEL"
    /// Used to get the current voice channel the client is in.
    case getSelectedVoiceChannel = "GET_SELECTED_VOICE_CHANNEL"
    /// Used to join or leave a text channel, group dm, or dm.
    case selectTextChannel       = "SELECT_TEXT_CHANNEL"
    /// Used to retrieve the client's voice settings.
    case getVoiceSettings        = "GET_VOICE_SETTINGS"
    /// Used to set the client's voice settings.
    case setVoiceSettings        = "SET_VOICE_SETTINGS"
    /// Used to capture a keyboard shortcut entered by the user.
    case captureShortcut         = "CAPTURE_SHORTCUT"
    /// Used to send info about certified hardware devices.
    case setCertifiedDevices     = "SET_CERTIFIED_DEVICES"
    /// Used to update a user's Rich Presence.
    case setActivity             = "SET_ACTIVITY"
    /// Used to consent to a Rich Presence Ask to Join request.
    case sendActivityJoinInvite  = "SEND_ACTIVITY_JOIN_INVITE"
    /// Used to reject a Rich Presence Ask to Join request.
    case closeActivityRequest    = "CLOSE_ACTIVITY_REQUEST"
}

/// Enum of all the event types that can be subscribed to with the Discord RPC API.
/// - SeeAlso: [Discord Reference](https://github.com/discord/discord-api-docs/blob/8ed15ce2a11beab51918a084cfd5450ea7a3a211/docs/topics/RPC.md#rpc-events)
public enum EventType: String, Codable {
    /// Non-subscription event sent immediately after connecting, contains server information.
    case ready                 = "READY"
    /// Non-subscription event sent when there is an error, including command responses.
    case error                 = "ERROR"
    /// Sent when a subscribed server's state changes.
    case guildStatus           = "GUILD_STATUS"
    /// Sent when a guild is created/joined on the client.
    case guildCreate           = "GUILD_CREATE"
    /// Sent when a channel is created/joined on the client.
    case channelCreate         = "CHANNEL_CREATE"
    /// Sent when the client joins a voice channel.
    case voiceChannelSelect    = "VOICE_CHANNEL_SELECT"
    /// Sent when a user joins a subscribed voice channel.
    case voiceStateCreate      = "VOICE_STATE_CREATE"
    /// Sent when a user's voice state changes in a subscribed voice channel (mute, volume, etc.).
    case voiceStateUpdate      = "VOICE_STATE_UPDATE"
    /// Sent when a user parts a subscribed voice channel.
    case voiceStateDelete      = "VOICE_STATE_DELETE"
    /// Sent when the client's voice settings update.
    case voiceSettingsUpdate   = "VOICE_SETTINGS_UPDATE"
    /// Sent when the client's voice connection status changes.
    case voiceConnectionStatus = "VOICE_CONNECTION_STATUS"
    /// Sent when a user in a subscribed voice channel speaks.
    case speakingStart         = "SPEAKING_START"
    /// Sent when a user in a subscribed voice channel stops speaking.
    case speakingStop          = "SPEAKING_STOP"
    /// Sent when a message is created in a subscribed text channel.
    case messageCreate         = "MESSAGE_CREATE"
    /// Sent when a message is updated in a subscribed text channel.
    case messageUpdate         = "MESSAGE_UPDATE"
    /// Sent when a message is deleted in a subscribed text channel.
    case messageDelete         = "MESSAGE_DELETE"
    /// Sent when the client receives a notification (mention or new message in eligible channels).
    case notificationCreate    = "NOTIFICATION_CREATE"
    /// Sent when the user presses a key during [shortcut capturing](https://github.com/discord/discord-api-docs/blob/8ed15ce2a11beab51918a084cfd5450ea7a3a211/docs/topics/RPC.md#DOCS_TOPICS_RPC/captureshortcut).
    case captureShortcutChange = "CAPTURE_SHORTCUT_CHANGE"
    /// Sent when the user clicks a Rich Presence join invite in chat to join a game.
    case activityJoin          = "ACTIVITY_JOIN"
    /// Sent when the user clicks a Rich Presence spectate invite in chat to spectate a game.
    case activitySpectate      = "ACTIVITY_SPECTATE"
    /// Sent when the user receives a Rich Presence Ask to Join request.
    case activityJoinRequest   = "ACTIVITY_JOIN_REQUEST"
}

/// Enum of all the guild features.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/guild#guild-object-guild-features)
public enum GuildFeature: String, Codable {
    /// Guild has access to set an animated guild icon
    case animatedIcon                  = "ANIMATED_ICON"
    /// Guild has access to set a guild banner image
    case banner                        = "BANNER"
    /// Guild has access to use commerce features (i.e. create store channels)
    case commerce                      = "COMMERCE"
    /// Guild can enable welcome screen, Membership Screening, stage channels and discovery, and receives community updates
    case community                     = "COMMUNITY"
    /// Guild is able to be discovered in the directory
    case discoverable                  = "DISCOVERABLE"
    /// Guild is able to be featured in the directory
    case featurable                    = "FEATURABLE"
    /// Guild has access to set an invite splash background
    case inviteSplash                  = "INVITE_SPLASH"
    /// Guild has enabled [Membership Screening](https://discord.com/developers/docs/resources/guild#membership-screening-object)
    case memberVerificationGateEnabled = "MEMBER_VERIFICATION_GATE_ENABLED"
    /// Guild has access to create news channels
    case news                          = "NEWS"
    /// Guild is partnered
    case partenered                    = "PARTNERED"
    /// Guild can be previewed before joining via Membership Screening or the directory
    case previewEnabled                = "PREVIEW_ENABLED"
    /// Guild has access to set a vanity URL
    case vanityURL                     = "VANITY_URL"
    /// Guild is verified
    case verified                      = "VERIFIED"
    /// Guild has access to set 384kbps bitrate in voice (previously VIP voice servers)
    case vipRegions                    = "VIP_REGIONS"
    /// Guild has enabled the welcome screen
    case welcomeScreenEnabled          = "WELCOME_SCREEN_ENABLED"
    /// Guild has enabled ticketed events
    case ticketedEventsEnabled         = "TICKETED_EVENTS_ENABLED"
    /// Guild has enabled monetization
    case monetizationEnabled           = "MONETIZATION_ENABLED"
    /// Guild has increased custom sticker slots
    case moreStickers                  = "MORE_STICKERS"
    /// Guild has access to the three day archive time for threads
    case threeDayThreadArchive         = "THREE_DAY_THREAD_ARCHIVE"
    /// Guild has access to the seven day archive time for threads
    case sevenDayThreadArchive         = "SEVEN_DAY_THREAD_ARCHIVE"
    /// Guild has access to create private threads
    case privateThreads                = "PRIVATE_THREADS"
}

/// Enum of all the channel types.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#channel-object-channel-types)
public enum ChannelType: Int, Codable {
    /// A text channel within a server
    case guildText          = 0
    /// A direct message between users
    case dm                 = 1
    /// A voice channel within a server
    case guildVoice         = 2
    /// A direct message between multiple users
    case groupDM            = 3
    /// An [organizational category](https://support.discord.com/hc/en-us/articles/115001580171-Channel-Categories-101) that contains up to 50 channels
    case guildCategory      = 4
    /// A channel that [users can follow and crosspost into their own server](https://support.discord.com/hc/en-us/articles/360032008192)
    case guildNews          = 5
    /// A channel in which game developers can [sell their game on Discord](https://discord.com/developers/docs/game-and-server-management/special-channels)
    case guildStore         = 6
    /// A temporary sub-channel within a `guildNews` channel
    case guildNewsThread    = 10
    /// A temporary sub-channel within a `guildText` channel
    case guildPublicThread  = 11
    /// A temporary sub-channel within a `guildText` channel that is only viewable by those invited and those with the MANAGE_THREADS permission
    case guildPrivateThread = 12
    /// A voice channel for [hosting events with an audience](https://support.discord.com/hc/en-us/articles/1500005513722)
    case guildStageVoice    = 13
}

/// Enum of all the default notification level.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/guild#guild-object-default-message-notification-level)
public enum DefaultMessageNotificationLevel: Int, Codable {
    /// Members will receive notifications for all messages by default
    case allMessages  = 0
    /// Members will receive notifications only for messages that @mention them by default
    case onlyMentions = 1
}

/// Enum of all explicit content filter levels.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level)
public enum ExplicitContentFilterLevel: Int, Codable {
    /// Media content will not be scanned
    case disabled            = 0
    /// Media content sent by members without roles will be scanned
    case membersWithoutRoles = 1
    /// Media content sent by all members will be scanned
    case allMembers          = 2
}

/// Enum of all MFA levels.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/guild#guild-object-mfa-level)
public enum MFALevel: Int, Codable {
    /// Guild has no MFA/2FA requirement for moderation actions
    case none     = 0
    /// Guild has a 2FA requirement for moderation actions
    case elevated = 1
}

/// Enum of all verification levels.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/guild#guild-object-verification-level)
public enum VerificationLevel: Int, Codable {
    /// Unrestricted
    case none     = 0
    /// Must have verified email on account
    case low      = 1
    /// Must be registered on Discord for longer than 5 minutes
    case medium   = 2
    /// Must be a member of the server for longer than 10 minutes
    case high     = 3
    /// Must have a verified phone number
    case veryHigh = 4
}

/// Enum of all guild NSFW levels.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/guild#guild-object-guild-nsfw-level)
public enum GuildNSFWLevel: Int, Codable {
    case defaultL      = 0
    case explicit      = 1
    case safe          = 2
    case ageRestricted = 3
}

/// Enum of all premium tiers.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/guild#guild-object-premium-tier)
public enum PremiumTier: Int, Codable {
    /// Guild has not unlocked any Server Boost perks
    case none  = 0
    /// Guild has unlocked Server Boost level 1 perks
    case tier1 = 1
    /// Guild has unlocked Server Boost level 2 perks
    case tier2 = 2
    /// Guild has unlocked Server Boost level 3 perks
    case tier3 = 3
}

/// Enum of all system channel flags.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/guild#guild-object-system-channel-flags)
public enum SystemChannelFlags: Int, Codable {
    /// Suppress member join notifications
    case suppressJoinNotifications          = 1
    /// Suppress server boost notifications
    case suppressPremiumSubscriptions       = 2
    /// Suppress server setup tips
    case suppressGuildReminderNotifications = 4
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#overwrite-object-overwrite-structure)
public enum OverwriteType: Int, Codable {
    case role   = 0
    case member = 1
}

/// Enum of all the video quality modes.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#channel-object-video-quality-modes)
public enum VideoQualityMode: Int, Codable {
    /// Discord chooses the quality for optimal performance
    case auto = 1
    /// 720p
    case full = 2
}

/// Enum of all the user flags that can be returned by the Discord RPC API.
/// - SeeAlso: [Discord Reference](https://github.com/discord/discord-api-docs/blob/55cd3d71082e9dc31cbd007a6e74b1cd6a82beeb/docs/resources/User.md#user-flags)
public enum UserFlag: Int, Codable {
    case none                      = 0
    case discordEmployee           = 1
    case partneredServerOwner      = 2
    case hypesquadEvents           = 4
    case bugHunterLevel1           = 8
    /// Not documented but this is the one I got during my tests (?)
    case normalUser                = 32
    case houseBravery              = 64
    case houseBrilliance           = 128
    case houseBalance              = 256
    case earlySupporter            = 512
    case teamUser                  = 1024
    case bugHunterLevel2           = 16384
    case verifiedBot               = 65536
    case earlyVerifiedBotDeveloper = 131072
    case discordCertifiedModerator = 262144
}

/// Enum of all premium ranks a Discord user can have.
/// - SeeAlso: [Discord Reference](https://github.com/discord/discord-api-docs/blob/55cd3d71082e9dc31cbd007a6e74b1cd6a82beeb/docs/resources/User.md#premium-types)
public enum PremiumType: Int, Codable {
    case none         = 0
    case nitroClassic = 1
    case nitro        = 2
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/gateway#presence-update-presence-update-event-fields)
public enum PresenceStatus: String, Codable {
    case idle
    case dnd
    case online
    case offline
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/gateway#activity-object-activity-types)
public enum ActivityType: Int, Codable {
    /// Format: Playing {name}; Exemple: "Playing Rocket League"
    case game      = 0
    /// Format: Streaming {details}; Exemple: "Streaming Rocket League"
    case streaming = 1
    /// Format: Listening to {name}; Exemple: "Listening to Spotify"
    case listening = 2
    /// Format: Watching {name}; Exemple: "Watching YouTube Together"
    case watching  = 3
    /// Format: {emoji} {name}; Exemple: ":smiley: I am cool"
    case custom    = 4
    /// Format: Competing in {name}; Exemple: "Competing in Arena World Champions"
    case competing = 5
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/stage-instance#stage-instance-object-privacy-level)
public enum PrivacyLevel: Int, Codable {
    /// The Stage instance is visible publicly, such as on Stage discovery.
    case publicP   = 1
    /// The Stage instance is visible to only guild members.
    case guildOnly = 2
}

/// Enum of all message types.
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#message-object-message-types)
public enum MessageType: Int, Codable {
    case defaultT                                = 0
    case recipientAdd                            = 1
    case recipientRemove                         = 2
    case call                                    = 3
    case channelNameChange                       = 4
    case channelIconChange                       = 5
    case channelPinnedMessage                    = 6
    case guildMemberJoin                         = 7
    case userPremiumGuildSubscription            = 8
    case userPremiumGuildSubscriptionTier1       = 9
    case userPremiumGuildSubscriptionTier2       = 10
    case userPremiumGuildSubscriptionTier3       = 11
    case channelFollowAdd                        = 12
    case guildDiscoveryDisqualified              = 14
    case guildDiscoveryRequalified               = 15
    case guildDiscoveryGracePeriodInitialWarning = 16
    case guildDiscoveryGracePeriodFinalWarning   = 17
    case threadCreated                           = 18
    case reply                                   = 19
    case applicationCommand                      = 20
    case threadStarterMessage                    = 21
    case guildInviteReminder                     = 22
}

/// Embed types are "loosely defined" and, for the most part, are not used by our clients for rendering
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#embed-object-embed-types)
public enum EmbedType: String, Codable {
    /// Generic embed rendered from embed attributes
    case rich
    /// Image embed
    case image
    /// Video embed
    case video
    /// Animated gif image embed rendered as a video embed
    case gifv
    /// Article embed
    case article
    /// Link embed
    case link
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#message-object-message-activity-types)
public enum MessageActivityType: Int, Codable {
    case join        = 1
    case spectate    = 2
    case listen      = 3
    case joinRequest = 5
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/interactions/message-components#component-object-component-types)
public enum ComponentType: Int, Codable {
    /// A container for other components
    case actionRow  = 1
    /// A button object
    case button     = 2
    /// A select menu for picking from choices
    case selectMenu = 3
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/interactions/message-components#button-object-button-styles)
public enum ButtonStyle: Int, Codable {
    /// Color: blurple; Required Field: custom_id
    case primary   = 1
    /// Color: grey; Required Field: custom_id
    case secondary = 2
    /// Color: green; Required Field: custom_id
    case success   = 3
    /// Color: red; Required Field: custom_id
    case danger    = 4
    /// Color: grey, navigates to a URL; Required Field: url
    case link      = 5
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#message-object-message-sticker-format-types)
public enum MessageStickerFormatType: Int, Codable {
    case png    = 1
    case apng   = 2
    case lottie = 3
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/application#application-object-application-flags)
public enum ApplicationFlag: Int, Codable {
    case gatewayPresence               = 4096
    case gatewayPresenceLimited        = 8192
    case gatewayGuildMembers           = 16384
    case gatewayGuildMembersLimited    = 32768
    case verificationPendingGuildLimit = 65536
    case embedded                      = 131072
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum)
public enum MembershipState: Int, Codable {
    case invited  = 1
    case accepted = 2
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#getvoicesettings-voice-settings-mode-object)
public enum VoiceSettingsModeType: String, Codable {
    case pushToTalk   = "PUSH_TO_TALK"
    case voidActivity = "VOICE_ACTIVITY"
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#getvoicesettings-key-types)
public enum KeyType: Int, Codable {
    case keyboardKey         = 0
    case mouseButton         = 1
    case keyboardModifierKey = 2
    case gamepadButton       = 3
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#setcertifieddevices-device-types)
public enum DeviceType: String, Codable {
    case audioInput  = "audioinput"
    case audioOutput = "audiooutput"
    case videoInput  = "videoinput"
}

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#voiceconnectionstatus-voice-connection-states)
public enum VoiceConnectionState: String, Codable {
    /// TCP disconnected
    case disconnected      = "DISCONNECTED"
    /// Waiting for voice endpoint
    case awaitingEndpoint  = "AWAITING_ENDPOINT"
    /// TCP authenticating
    case authenticating    = "AUTHENTICATING"
    /// TCP connecting
    case connecting        = "CONNECTING"
    /// TCP connected
    case connectec         = "CONNECTED"
    /// TCP connected, Voice disconnected
    case voiceDisconnected = "VOICE_DISCONNECTED"
    /// TCP connected, Voice connecting
    case voiceConnecting   = "VOICE_CONNECTING"
    /// TCP connected, Voice connected
    case voiceConnected    = "VOICE_CONNECTED"
    /// No route to host
    case noRoute           = "NO_ROUTE"
    /// WebRTC ice checking
    case iceChecking       = "ICE_CHECKING"
}

// ------------------ //
// Internal constants //
// ------------------ //
/// Opcode used by Discord UDS RPC API.
/// - SeeAlso: [Discord Reference](https://github.com/discord/discord-rpc/blob/963aa9f3e5ce81a4682c6ca3d136cddda614db33/src/rpc_connection.h#L17)
enum OPCode: UInt32 {
    case handshake = 0
    case frame     = 1
    case close     = 2
    case ping      = 3
    case pong      = 4
}

/// RPC API version.
/// - SeeAlso: [Discord Reference](https://github.com/discord/discord-api-docs/blob/8ed15ce2a11beab51918a084cfd5450ea7a3a211/docs/topics/RPC.md#rpc-versions)
let apiVersion = 1

/// Range of suffix used by Discord for its UDS file.
/// - SeeAlso: [Discord Reference](https://github.com/discord/discord-rpc/blob/8e0c7848a6e7a95f9257dc6903d2d298352583e9/documentation/hard-mode.md#notes)
let udsSuffixRange = 0 ... 9
