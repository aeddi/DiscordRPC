import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#ready-rpc-server-configuration-object)
public class Config: Codable {
    /// Server's cdn
    public let cdnHost: String
    /// Server's api endpoint
    public let apiEndpoint: String
    /// Server's environment
    public let environment: String

    private enum CodingKeys: String, CodingKey {
        case cdnHost     = "cdn_host"
        case apiEndpoint = "api_endpoint"
        case environment
    }
}
