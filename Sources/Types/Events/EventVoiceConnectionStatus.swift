import Foundation

public class EventVoiceConnectionStatus: Frame {
    public let data: EventVoiceConnectionStatusData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventVoiceConnectionStatusData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .voiceConnectionStatus,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventVoiceConnectionStatus {
        return try newJSONDecoder().decode(EventVoiceConnectionStatus.self, from: data)
    }

    public class EventVoiceConnectionStatusData: Codable {
        /// One of the voice connection states listed below
        public let state: VoiceConnectionState
        /// Hostname of the connected voice server
        public let hostname: String
        /// Last 20 pings (in ms)
        public let pings: [Int]
        /// Average ping (in ms)
        public let averagePing: Int
        /// Last ping (in ms)
        public let lastPing: Int

        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case state
            case hostname
            case pings
            case averagePing = "average_ping"
            case lastPing    = "last_ping"
        }
    }
}
