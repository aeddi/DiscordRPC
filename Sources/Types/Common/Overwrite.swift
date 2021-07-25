import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/channel#overwrite-object-overwrite-structure)
public class Overwrite: Codable {
    /// Role or user iD
    public let id: String
    /// Either 0 (role) or 1 (member)
    public let type: OverwriteType
    /// Permission bit set
    public let allow: String
    /// Permission bit set
    public let deny: String
}
