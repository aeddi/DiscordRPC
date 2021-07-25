import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#setuservoicesettings-pan-object)
public class Pan: Codable {
    /// Left pan of user (min: 0.0, max: 1.0)
    public let left: Float
    /// Right pan of user (min: 0.0, max: 1.0)
    public let right: Float
}
