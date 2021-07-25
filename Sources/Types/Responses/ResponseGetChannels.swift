import Foundation

public class ResponseGetChannels: Frame {
    public let data: ResponseGetChannelsData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(ResponseGetChannelsData.self, forKey: .data)
        try super.init(from: decoder, withFixedCmdType: .getChannels, withFixedEventType: nil, withNonce: true)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseGetChannels {
        return try newJSONDecoder().decode(ResponseGetChannels.self, from: data)
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#getchannels-get-channels-response-structure)
    public class ResponseGetChannelsData: Codable {
        /// Guild channels the user is in
        public let channels: [Channel]
    }
}
