import Foundation

public class EventChannelCreate: Frame {
    public let data: EventChannelCreateData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventChannelCreateData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .channelCreate,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventChannelCreate {
        return try newJSONDecoder().decode(EventChannelCreate.self, from: data)
    }

    public class EventChannelCreateData: Codable {
        /// Channel ID
        public let id: String
        /// Name of the channel
        public let name: String
        /// Channel type (guild text: 0, guild voice: 2, dm: 1, group dm: 3)
        public let type: Int
    }
}
