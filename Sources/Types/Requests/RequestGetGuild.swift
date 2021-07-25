import Foundation

class RequestGetGuild: Encodable {
    let cmd: CommandType = .getGuild
    let nonce: String
    let args: RequestGetGuildArgs

    private enum CodingKeys: String, CodingKey {
        case cmd
        case nonce
        case args
    }

    init(nonce: String, guildID: String, timeout: Int) {
        self.nonce = nonce
        self.args = RequestGetGuildArgs(guildID: guildID, timeout: timeout)
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

    class RequestGetGuildArgs: Encodable {
        let guildID: String
        let timeout: Int

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case guildID = "guild_id"
            case timeout
        }

        init(guildID: String, timeout: Int) {
            self.guildID = guildID
            self.timeout = timeout
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(guildID, forKey: .guildID)
            try container.encode(timeout, forKey: .timeout)
        }
    }
}
