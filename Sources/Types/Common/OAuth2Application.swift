import Foundation

/// - SeeAlso: [Discord Reference](https://github.com/discord/discord-api-docs/blob/2e93c2bd6c08225c0b806ebbdf3bd36c8eb9e51c/docs/topics/RPC.md#oauth2-application-structure)
public class OAuth2Application: Codable {
    /// Application description
    public let description: String
    /// Hash of the icon
    public let icon: String?
    /// Application client ID
    public let id: String
    /// Array of rpc origin urls
    public let rpcOrigins: String?
    /// Application name
    public let name: String

    private enum CodingKeys: String, CodingKey {
        case description
        case icon
        case id
        case rpcOrigins = "rpc_origins"
        case name
    }
}
