import Foundation

public class ResponseGetGuild: Frame {
    public let data: ResponseGetGuildData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(ResponseGetGuildData.self, forKey: .data)
        try super.init(from: decoder, withFixedCmdType: .getGuild, withFixedEventType: nil, withNonce: true)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseGetGuild {
        return try newJSONDecoder().decode(ResponseGetGuild.self, from: data)
    }

    public class ResponseGetGuildData: Codable {
        /// Guild ID
        public let id: String
        /// Guild name
        public let name: String
        /// Guild icon url
        public let iconUrl: String
        /// Members of the guild (deprecated; always empty array)
        public let members: [GuildMember]

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case iconUrl = "icon_url"
            case members
        }
    }
}
