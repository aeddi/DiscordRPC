import Foundation

class RequestGetChannels: Encodable {
    let cmd: CommandType = .getChannels
    let nonce: String
    let args: RequestGetChannelsArgs

    private enum CodingKeys: String, CodingKey {
        case cmd
        case nonce
        case args
    }

    init(nonce: String, guildID: String) {
        self.nonce = nonce
        self.args = RequestGetChannelsArgs(guildID: guildID)
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

    class RequestGetChannelsArgs: Encodable {
        let guildID: String

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case guildID = "guild_id"
        }

        init(guildID: String) {
            self.guildID = guildID
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(guildID, forKey: .guildID)
        }
    }
}
