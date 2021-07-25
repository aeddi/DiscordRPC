import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#getvoicesettings-voice-settings-input-object)
public class VoiceSettingsIO: Codable {
    /// Device ID
    public let deviceID: String?
    /// Input/Output voice level (min: 0, max: 100)
    public let volume: Float?
    /// Array of read-only device objects containing `id` and `name` string keys
    public let availableDevices: [Device]?

    private enum CodingKeys: String, CodingKey {
        case deviceID         = "device_id"
        case volume
        case availableDevices = "available_devices"
    }

    public init(deviceID: String? = nil, volume: Float? = nil, availableDevices: [Device]? = nil) {
        self.deviceID = deviceID
        self.volume = volume
        self.availableDevices = availableDevices
    }

    public class Device: Codable {
        public let id: String
        public let name: String

        public init(id: String, name: String) {
            self.id = id
            self.name = name
        }
    }
}
