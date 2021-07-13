import Foundation

class RequestGetGuilds: Encodable {
    let cmd: CommandType = .getGuilds
    let nonce: String
    let args: RequestGetGuildsArgs = RequestGetGuildsArgs()

    private enum CodingKeys: String, CodingKey {
        case cmd
        case nonce
        case args
    }

    init(nonce: String) throws {
        self.nonce = nonce
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
}

struct RequestGetGuildsArgs: Encodable {}
