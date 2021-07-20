import Foundation

class RequestSetCertifiedDevices: Encodable {
    let cmd: CommandType = .setCertifiedDevices
    let nonce: String
    let args: RequestSetCertifiedDevicesArgs

    private enum CodingKeys: String, CodingKey {
        case cmd
        case nonce
        case args
    }

    init(nonce: String, devices: [Device]) {
        self.nonce = nonce
        self.args = RequestSetCertifiedDevicesArgs(devices: devices)
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

    class RequestSetCertifiedDevicesArgs: Encodable {
        /// A list of devices for your manufacturer, in order of priority
        let devices: [Device]

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case devices
        }

        init(devices: [Device]) {
            self.devices = devices
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(devices, forKey: .devices)
        }
    }
}
