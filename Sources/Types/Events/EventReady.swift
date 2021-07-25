import Foundation

public class EventReady: Frame {
    public let data: EventReadyData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventReadyData.self, forKey: .data)
        try super.init(from: decoder, withFixedCmdType: .dispatch, withFixedEventType: .ready, withNonce: false)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventReady {
        return try newJSONDecoder().decode(EventReady.self, from: data)
    }

    public class EventReadyData: Codable {
        public let v: Int
        public let config: Config
        public let user: User

        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case v
            case config
            case user
        }
    }
}
