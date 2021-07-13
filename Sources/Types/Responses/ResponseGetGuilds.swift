import Foundation

public class ResponseGetGuilds: Frame {
    public let data: ResponseGetGuildsData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(ResponseGetGuildsData.self, forKey: .data)
        try super.init(from: decoder, withFixedCmdType: .authenticate, withFixedEventType: nil, withNonce: true)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseGetGuilds {
        return try newJSONDecoder().decode(ResponseGetGuilds.self, from: data)
    }
}

public class ResponseGetGuildsData: Codable {
    public let guilds: [Guild]
}
