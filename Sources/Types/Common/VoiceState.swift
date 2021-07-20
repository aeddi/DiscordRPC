import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/voice#voice-state-object-voice-state-structure)
public class VoiceState: Codable {
    /// The guild ID this voice state is for.
    public let guildID: String?
    /// The channel ID this user is connected to.
    public let channelID: String?
    /// The user ID this voice state is for.
    public let userID: String
    /// The guild member this voice state is for.
    public let member: GuildMember?
    /// The session ID for this voice state.
    public let sessionID: String
    /// Whether this user is deafened by the server.
    public let deaf: Bool
    /// Whether this user is muted by the server.
    public let mute: Bool
    /// Whether this user is locally deafened.
    public let selfDeaf: Bool
    /// Whether this user is locally muted.
    public let selfMute: Bool
    /// Whether this user is streaming using "Go Live".
    public let selfStream: Bool?
    /// Whether this user's camera is enabled.
    public let selfVideo: Bool
    /// Whether this user is muted by the current user.
    public let suppress: Bool
    /// The time at which the user requested to speak.
    public let requestToSpeakTimestamp: Date?

    private enum CodingKeys: String, CodingKey {
        case guildID                 = "guild_id"
        case channelID               = "channel_id"
        case userID                  = "user_id"
        case member
        case sessionID               = "session_id"
        case deaf
        case mute
        case selfDeaf                = "self_deaf"
        case selfMute                = "self_mute"
        case selfStream              = "self_stream"
        case selfVideo               = "self_video"
        case suppress
        case requestToSpeakTimestamp = "request_to_speak_timestamp"
    }
}
