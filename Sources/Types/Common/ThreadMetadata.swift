import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#thread-metadata-object-thread-metadata-structure)
public class ThreadMetadata: Codable {
    /// Whether the thread is archived
    public let archived: Bool
    /// Duration in minutes to automatically archive the thread after recent activity, can be set to: 60, 1440, 4320, 10080
    public let autoArchiveDuration: Int
    /// Timestamp when the thread's archive status was last changed, used for calculating recent activity
    public let archiveTimestamp: Date
    /// Whether the thread is locked; when a thread is locked, only users with MANAGE_THREADS can unarchive it
    public let locked: Bool?

    private enum CodingKeys: String, CodingKey {
        case archived
        case autoArchiveDuration = "auto_archive_duration"
        case archiveTimestamp    = "archive_timestamp"
        case locked
    }
}
