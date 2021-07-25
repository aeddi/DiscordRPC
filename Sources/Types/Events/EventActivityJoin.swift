import Foundation

public class EventActivityJoin: Frame {
    public let data: EventActivityJoinData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventActivityJoinData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .activityJoin,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventActivityJoin {
        return try newJSONDecoder().decode(EventActivityJoin.self, from: data)
    }

    public class EventActivityJoinData: Codable {
        // The [join_secret](https://discord.com/developers/docs/rich-presence/how-to#updating-presence-update-presence-payload-fields) for the given invite
        public let secret: String
    }
}
