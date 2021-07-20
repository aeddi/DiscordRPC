import Foundation

class RequestSelectTextChannel: Encodable {
    let cmd: CommandType = .selectTextChannel
    let nonce: String
    let args: RequestSelectTextChannelArgs

    private enum CodingKeys: String, CodingKey {
        case cmd
        case nonce
        case args
    }

    init(nonce: String, channelID: String, timeout: Int) {
        self.nonce = nonce
        self.args = RequestSelectTextChannelArgs(channelID: channelID, timeout: timeout)
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

    class RequestSelectTextChannelArgs: Encodable {
        /// Channel ID to join (or null to leave)
        let channelID: String?
        /// Asynchronously join channel with time to wait before timing out
        let timeout: Int

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case channelID = "channel_id"
            case timeout
        }

        init(channelID: String, timeout: Int) {
            self.channelID = channelID
            self.timeout = timeout
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(channelID, forKey: .channelID)
            try container.encode(timeout, forKey: .timeout)
        }
    }
}
