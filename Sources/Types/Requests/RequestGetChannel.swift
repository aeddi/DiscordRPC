import Foundation

class RequestGetChannel: Encodable {
    let cmd: CommandType = .getChannel
    let nonce: String
    let args: RequestGetChannelArgs

    private enum CodingKeys: String, CodingKey {
        case cmd
        case nonce
        case args
    }

    init(nonce: String, channelID: String) {
        self.nonce = nonce
        self.args = RequestGetChannelArgs(channelID: channelID)
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

    class RequestGetChannelArgs: Encodable {
        let channelID: String

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case channelID = "channel_id"
        }

        init(channelID: String) {
            self.channelID = channelID
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(channelID, forKey: .channelID)
        }
    }
}
