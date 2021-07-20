import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/gateway#activity-object-activity-structure)
public class Activity: Codable {
    /// The activity's name
    public let name: String
    /// [Activity type](https://discord.com/developers/docs/topics/gateway#activity-object-activity-types)
    public let type: ActivityType
    /// Stream url, is validated when type is 1
    public let url: String?
    /// Unix timestamp (in milliseconds) of when the activity was added to the user's session
    public let createdAt: Int
    /// Unix timestamps for start and/or end of the game
    public let timestamps: ActivityTimestamps?
    /// Application id for the game
    public let applicationID: String?
    /// What the player is currently doing
    public let details: String?
    /// The user's current party status
    public let state: String?
    /// The emoji used for a custom status
    public let emoji: Emoji?
    /// Information for the current party of the player
    public let party: ActivityParty?
    /// Images for the presence and their hover texts
    public let assets: ActivityAssets?
    /// Secrets for Rich Presence joining and spectating
    public let secrets: ActivitySecrets?
    /// Whether or not the activity is an instanced game session
    public let instance: Bool?
    /// [Activity flags](https://discord.com/developers/docs/topics/gateway#activity-object-activity-flags) ORd together, describes what the payload includes
    public let flags: Int?
    /// The custom buttons shown in the Rich Presence (max 2)
    public let buttons: [ActivityButton]?

    private enum CodingKeys: String, CodingKey {
        case name
        case type
        case url
        case createdAt     = "created_at"
        case timestamps
        case applicationID = "application_id"
        case details
        case state
        case emoji
        case party
        case assets
        case secrets
        case instance
        case flags
        case buttons
    }

    public init(
        name: String,
        type: ActivityType,
        url: String? = nil,
        createdAt: Int,
        timestamps: Activity.ActivityTimestamps? = nil,
        applicationID: String? = nil,
        details: String? = nil,
        state: String? = nil,
        emoji: Emoji? = nil,
        party: Activity.ActivityParty? = nil,
        assets: Activity.ActivityAssets? = nil,
        secrets: Activity.ActivitySecrets? = nil,
        instance: Bool? = nil,
        flags: Int? = nil,
        buttons: [Activity.ActivityButton]? = nil) {
        self.name = name
        self.type = type
        self.url = url
        self.createdAt = createdAt
        self.timestamps = timestamps
        self.applicationID = applicationID
        self.details = details
        self.state = state
        self.emoji = emoji
        self.party = party
        self.assets = assets
        self.secrets = secrets
        self.instance = instance
        self.flags = flags
        self.buttons = buttons
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/gateway#activity-object-activity-timestamps)
    public class ActivityTimestamps: Codable {
        /// Unix time (in milliseconds) of when the activity started
        public let start: Int?
        /// Unix time (in milliseconds) of when the activity ends
        public let end: Int?

        public init(start: Int? = nil, end: Int? = nil) {
            self.start = start
            self.end = end
        }
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/gateway#activity-object-activity-party)
    public class ActivityParty: Codable {
        /// The ID of the party
        public let id: String?
        /// Array of two integers (current_size, max_size), used to show the party's current and maximum size
        public let size: [Int]?

        public init(id: String? = nil, size: [Int]? = nil) {
            self.id = id
            self.size = size
        }
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/gateway#activity-object-activity-assets)
    public class ActivityAssets: Codable {
        /// The ID for a large asset of the activity, usually a snowflake
        public let largeImage: String?
        /// Text displayed when hovering over the large image of the activity
        public let largeText: String?
        /// The ID for a small asset of the activity, usually a snowflake
        public let smallImage: String?
        /// Text displayed when hovering over the small image of the activity
        public let smallText: String?

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case largeImage = "large_image"
            case largeText  = "large_text"
            case smallImage = "small_image"
            case smallText  = "small_text"
        }

        public init(
            largeImage: String? = nil,
            largeText: String? = nil,
            smallImage: String? = nil,
            smallText: String? = nil
        ) {
            self.largeImage = largeImage
            self.largeText = largeText
            self.smallImage = smallImage
            self.smallText = smallText
        }
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/gateway#activity-object-activity-secrets)
    public class ActivitySecrets: Codable {
        /// The secret for joining a party
        public let join: String?
        /// The secret for spectating a game
        public let spectate: String?
        /// The secret for a specific instanced match
        public let match: String?

        public init(join: String? = nil, spectate: String? = nil, match: String? = nil) {
            self.join = join
            self.spectate = spectate
            self.match = match
        }
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/gateway#activity-object-activity-buttons)
    public class ActivityButton: Codable {
        /// The text shown on the button (1-32 characters)
        public let label: String
        /// The url opened when clicking the button (1-512 characters)
        public let url: String

        public init(label: String, url: String) {
            self.label = label
            self.url = url
        }
    }
}
