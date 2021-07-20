import Foundation

public class EventSpeakingStop: Frame {
    public let data: EventSpeakingStopData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventSpeakingStopData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .speakingStop,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventSpeakingStop {
        return try newJSONDecoder().decode(EventSpeakingStop.self, from: data)
    }

    public class EventSpeakingStopData: Codable {
        /// ID of user who started/stopped speaking
        public let userID: String

        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
        }
    }
}
