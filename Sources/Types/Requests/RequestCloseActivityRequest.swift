import Foundation

class RequestCloseActivityRequest: Encodable {
    let cmd: CommandType = .closeActivityRequest
    let nonce: String
    let args: RequestCloseActivityRequestArgs

    private enum CodingKeys: String, CodingKey {
        case cmd
        case nonce
        case args
    }

    init(nonce: String, userID: String) {
        self.nonce = nonce
        self.args = RequestCloseActivityRequestArgs(userID: userID)
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

    class RequestCloseActivityRequestArgs: Encodable {
        let userID: String

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case userID = "user_id"
        }

        init(userID: String) {
            self.userID = userID
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(userID, forKey: .userID)
        }
    }
}
