import Foundation

public class EventNotificationCreate: Frame {
    public let data: EventNotificationCreateData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventNotificationCreateData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .notificationCreate,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventNotificationCreate {
        return try newJSONDecoder().decode(EventNotificationCreate.self, from: data)
    }

    public class EventNotificationCreateData: Codable {
        /// ID of channel where notification occurred
        public let channelID: String
        /// Message that generated this notification
        public let message: Message
        /// Icon url of the notification
        public let iconUrl: String
        /// Title of the notification
        public let title: String
        /// Body of the notification
        public let body: String

        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case channelID = "channel_id"
            case message
            case iconUrl   = "icon_url"
            case title
            case body
        }
    }
}
