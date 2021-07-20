import Foundation

public class ResponseSetUserVoiceSettings: Frame {
    public let data: UserVoiceSettings

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(UserVoiceSettings.self, forKey: .data)
        try super.init(from: decoder, withFixedCmdType: .setUserVoiceSettings, withFixedEventType: nil, withNonce: true)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseSetUserVoiceSettings {
        return try newJSONDecoder().decode(ResponseSetUserVoiceSettings.self, from: data)
    }

    public class ResponseSubscribeData: Codable {
        public let evt: EventType
    }
}
