import Foundation

public class EventVoiceSettingsUpdate: Frame {
    public let data: VoiceSettings

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(VoiceSettings.self, forKey: .data)
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

    public override class func from(data: Data) throws -> EventVoiceSettingsUpdate {
        return try newJSONDecoder().decode(EventVoiceSettingsUpdate.self, from: data)
    }
}
