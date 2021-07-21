import Foundation

public class ResponseSelectTextChannel: Frame {
    public let data: ResponseSelectTextChannelData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(ResponseSelectTextChannelData.self, forKey: .data)
        try super.init(from: decoder, withFixedCmdType: .selectTextChannel, withFixedEventType: nil, withNonce: true)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseSelectTextChannel {
        return try newJSONDecoder().decode(ResponseSelectTextChannel.self, from: data)
    }

    public class ResponseSelectTextChannelData: ResponseGetChannel.ResponseGetChannelData {}
}
