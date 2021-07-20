import Foundation

class RequestSetActivity: Encodable {
    let cmd: CommandType = .setActivity
    let nonce: String
    let args: RequestSetActivityArgs

    private enum CodingKeys: String, CodingKey {
        case cmd
        case nonce
        case args
    }

    init(nonce: String, pid: Int, activity: Activity) {
        self.nonce = nonce
        self.args = RequestSetActivityArgs(pid: pid, activity: activity)
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

    class RequestSetActivityArgs: Encodable {
        let pid: Int
        let activity: Activity

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case pid
            case activity
        }

        init(pid: Int, activity: Activity) {
            self.pid = pid
            self.activity = activity
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(pid, forKey: .pid)
            try container.encode(activity, forKey: .activity)
        }
    }
}
