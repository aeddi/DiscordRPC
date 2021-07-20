import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#setuservoicesettings-set-user-voice-settings-argument-and-response-structure)
public class UserVoiceSettings: Codable {
    /// User ID
    public let userID: String
    /// Set the pan of the user
    public let pan: Pan?
    /// Set the volume of user (defaults to 100, min 0, max 200)
    public let volume: Int?
    /// Set the mute state of the user
    public let mute: Bool?

    private enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case pan
        case volume
        case mute
    }

    init(userID: String, pan: Pan?, volume: Int?, mute: Bool?) {
        self.userID = userID
        self.pan = pan
        self.volume = volume
        self.mute = mute
    }
}
