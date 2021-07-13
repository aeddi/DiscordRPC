import Foundation

public class EventVoiceChannelSelect: Frame {
    public let data: EventVoiceChannelSelectData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventVoiceChannelSelectData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .voiceChannelSelect,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventVoiceChannelSelect {
        return try newJSONDecoder().decode(EventVoiceChannelSelect.self, from: data)
    }
}

public class EventVoiceChannelSelectData: Codable {
    public let channelID: String?
    public let guildID: String?

    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case guildID = "guild_id"
    }
}
