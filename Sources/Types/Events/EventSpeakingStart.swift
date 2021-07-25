import Foundation

public class EventSpeakingStart: Frame {
    public let data: EventSpeakingStartData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventSpeakingStartData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .speakingStart,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventSpeakingStart {
        return try newJSONDecoder().decode(EventSpeakingStart.self, from: data)
    }

    public class EventSpeakingStartData: Codable {
        /// ID of user who started/stopped speaking
        public let userID: String

        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
        }
    }
}
