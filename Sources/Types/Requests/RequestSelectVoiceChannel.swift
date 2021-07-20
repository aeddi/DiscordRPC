import Foundation

class RequestSelectVoiceChannel: Encodable {
    let cmd: CommandType = .selectVoiceChannel
    let nonce: String
    let args: RequestSelectVoiceChannelArgs

    private enum CodingKeys: String, CodingKey {
        case cmd
        case nonce
        case args
    }

    init(nonce: String, channelID: String?, timeout: Int, force: Bool) {
        self.nonce = nonce
        self.args = RequestSelectVoiceChannelArgs(channelID: channelID, timeout: timeout, force: force)
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

    class RequestSelectVoiceChannelArgs: Encodable {
        /// Channel ID to join (or null to leave)
        let channelID: String?
        /// Asynchronously join channel with time to wait before timing out
        let timeout: Int
        /// Forces a user to join a voice channel
        let force: Bool

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case channelID = "channel_id"
            case timeout
            case force
        }

        init(channelID: String?, timeout: Int, force: Bool) {
            self.channelID = channelID
            self.timeout = timeout
            self.force = force
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(channelID, forKey: .channelID)
            try container.encode(timeout, forKey: .timeout)
            try container.encode(force, forKey: .force)
        }
    }
}
