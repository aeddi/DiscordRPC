import Foundation

public class EventVoiceStateUpdate: Frame {
    public let data: EventVoiceStateUpdateData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventVoiceStateUpdateData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .dispatch,
            withFixedEventType: .voiceStateUpdate,
            withNonce: false
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> EventVoiceStateUpdate {
        return try newJSONDecoder().decode(EventVoiceStateUpdate.self, from: data)
    }

    public class EventVoiceStateUpdateData: Codable {
        public let voiceState: VoiceState
        public let user: User
        public let nick: String?
        public let volume: Int?
        public let mute: Bool?
        public let pan: Pan?

        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case voiceState = "voice_state"
            case user
            case nick
            case volume
            case mute
            case pan
        }
    }
}
