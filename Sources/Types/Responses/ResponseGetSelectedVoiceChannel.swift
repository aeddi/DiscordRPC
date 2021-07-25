import Foundation

public class ResponseGetSelectedVoiceChannel: Frame {
    public let data: ResponseGetSelectedVoiceChannelData?

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent(ResponseGetSelectedVoiceChannelData.self, forKey: .data)
        try super.init(
            from: decoder,
            withFixedCmdType: .getSelectedVoiceChannel,
            withFixedEventType: nil,
            withNonce: true
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseGetSelectedVoiceChannel {
        return try newJSONDecoder().decode(ResponseGetSelectedVoiceChannel.self, from: data)
    }

    public class ResponseGetSelectedVoiceChannelData: ResponseGetChannel.ResponseGetChannelData {}
}
