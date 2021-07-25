import Foundation

public class EventGuildStatus: Frame {
    public let data: EventGuildStatusData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventGuildStatusData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .guildStatus,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventGuildStatus {
        return try newJSONDecoder().decode(EventGuildStatus.self, from: data)
    }

    public class EventGuildStatusData: Codable {
        /// Guild with requested ID
        public let guild: Guild
        /// Number of online users in guild (deprecated; always 0)
        public let online: Int
    }
}
