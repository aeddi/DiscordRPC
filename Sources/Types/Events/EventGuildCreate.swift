import Foundation

public class EventGuildCreate: Frame {
    public let data: EventGuildCreateData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventGuildCreateData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .guildCreate,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventGuildCreate {
        return try newJSONDecoder().decode(EventGuildCreate.self, from: data)
    }

    public class EventGuildCreateData: Codable {
        /// Guild ID
        public let id: String
        /// Name of the guild
        public let name: String
    }
}
