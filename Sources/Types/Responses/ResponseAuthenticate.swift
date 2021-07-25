import Foundation

public class ResponseAuthenticate: Frame {
    public let data: ResponseAuthenticateData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(ResponseAuthenticateData.self, forKey: .data)
        try super.init(from: decoder, withFixedCmdType: .authenticate, withFixedEventType: nil, withNonce: true)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseAuthenticate {
        return try newJSONDecoder().decode(ResponseAuthenticate.self, from: data)
    }

    public class ResponseAuthenticateData: Codable {
        public let user: User
        public let scopes: [OAuth2Scope]
        public let expires: Date
        public let application: OAuth2Application
        public let accessToken: String

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case user
            case scopes
            case expires
            case application
            case accessToken = "access_token"
        }
    }
}
