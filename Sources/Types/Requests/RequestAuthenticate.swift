import Foundation

class RequestAuthenticate: Encodable {
    let cmd: CommandType = .authenticate
    let nonce: String
    let args: RequestAuthenticateArgs

    private enum CodingKeys: String, CodingKey {
        case cmd
        case nonce
        case args
    }

    init(nonce: String, accessToken: String) {
        self.nonce = nonce
        self.args = RequestAuthenticateArgs(accessToken: accessToken)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cmd, forKey: .cmd)
        try container.encode(nonce, forKey: .nonce)
        try container.encode(args, forKey: .args)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString() throws -> String {
        return String(data: try self.jsonData(), encoding: .utf8)!
    }

    class RequestAuthenticateArgs: Encodable {
        let accessToken: String

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
        }

        init(accessToken: String) {
            self.accessToken = accessToken
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(accessToken, forKey: .accessToken)
        }
    }
}
