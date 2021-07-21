import Foundation

public class UserVoiceState: Codable {
    public let voiceState: VoiceState
    public let user: User
    public let nick: String?
    public let volume: Float?
    public let mute: Bool?
    public let pan: Pan?

    private enum CodingKeys: String, CodingKey {
        case voiceState = "voice_state"
        case user
        case nick
        case volume
        case mute
        case pan
    }
}
