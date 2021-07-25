import Foundation

public class EventActivityJoinRequest: Frame {
    public let data: EventActivityJoinRequestData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventActivityJoinRequestData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .activityJoinRequest,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventActivityJoinRequest {
        return try newJSONDecoder().decode(EventActivityJoinRequest.self, from: data)
    }

    public class EventActivityJoinRequestData: Codable {
        /// Information about the user requesting to join
        public let user: User
    }
}
