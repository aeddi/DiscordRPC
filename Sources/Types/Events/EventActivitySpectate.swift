import Foundation

public class EventActivitySpectate: Frame {
    public let data: EventActivitySpectateData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventActivitySpectateData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .activitySpectate,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventActivitySpectate {
        return try newJSONDecoder().decode(EventActivitySpectate.self, from: data)
    }

    public class EventActivitySpectateData: Codable {
        /// The [spectate_secret](https://discord.com/developers/docs/rich-presence/how-to#updating-presence-update-presence-payload-fields) for the given invite
        public let secret: String
    }
}
