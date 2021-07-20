import Foundation

public class EventMessageUpdate: Frame {
    public let data: EventMessageUpdateData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventMessageUpdateData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .messageUpdate,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventMessageUpdate {
        return try newJSONDecoder().decode(EventMessageUpdate.self, from: data)
    }

    public class EventMessageUpdateData: Codable {
        /// ID of channel where notification occurred
        public let channelID: String
        /// Message that was updated
        public let message: Message

        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case channelID = "channel_id"
            case message
        }
    }
}
