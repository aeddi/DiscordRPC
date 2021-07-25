import Foundation

class RequestSetUserVoiceSettings: Encodable {
    let cmd: CommandType = .setUserVoiceSettings
    let nonce: String
    let args: UserVoiceSettings

    private enum CodingKeys: String, CodingKey {
        case cmd
        case nonce
        case args
    }

    init(nonce: String, userID: String, pan: Pan?, volume: Int?, mute: Bool?) {
        self.nonce = nonce
        self.args = UserVoiceSettings(userID: userID, pan: pan, volume: volume, mute: mute)
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
