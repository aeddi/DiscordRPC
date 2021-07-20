import Foundation

public class ResponseGetChannel: Frame {
    public let data: ResponseGetChannelData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(ResponseGetChannelData.self, forKey: .data)
        try super.init(from: decoder, withFixedCmdType: .getChannel, withFixedEventType: nil, withNonce: true)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseGetChannel {
        return try newJSONDecoder().decode(ResponseGetChannel.self, from: data)
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#getchannel-get-channel-response-structure)
    public class ResponseGetChannelData: Codable {
        /// Channel ID
        public let id: String
        /// Channel's guild ID
        public let guildID: String
        /// Channel name
        public let name: String
        /// Channel type (guild text: 0, guild voice: 2, dm: 1, group dm: 3)
        public let type: ChannelType
        /// (text) channel topic
        public let topic: String
        /// (voice) bitrate of voice channel
        public let bitrate: Int
        /// (voice) user limit of voice channel (0 for none)
        public let userLimit: Int
        /// Position of channel in channel list
        public let position: Int
        /// (voice) channel's voice states
        public let voiceStates: [VoiceState]
        /// (text) channel's messages
        public let messages: [Message]

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case id
            case guildID     = "guild_id"
            case name
            case type
            case topic
            case bitrate
            case userLimit   = "user_limit"
            case position
            case voiceStates = "voice_states"
            case messages
        }
    }
}
