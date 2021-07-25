import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#thread-member-object-thread-member-structure)
public class ThreadMember: Codable {
    /// The ID of the thread
    public let id: String
    /// The ID of the user
    public let userID: String?
    /// The time the current user last joined the thread
    public let joinTimestamp: Date
    /// Any user-thread settings, currently only used for notifications
    public let flags: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case userID        = "user_id"
        case joinTimestamp = "join_timestamp"
        case flags
    }
}
