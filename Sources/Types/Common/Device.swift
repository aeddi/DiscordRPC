import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#setcertifieddevices-device-object)
public class Device: Codable {
    /// The type of device
    public let type: DeviceType
    /// The device's Windows UUID
    public let id: String
    /// The hardware vendor
    public let vendor: Vendor
    /// The model of the product
    public let model: Model
    /// UUIDs of related devices
    public let related: [String]
    /// If the device's native echo cancellation is enabled
    public let echoCancellation: Bool?
    /// If the device's native noise suppression is enabled
    public let noiseSuppression: Bool?
    /// If the device's native automatic gain control is enabled
    public let automaticGainControl: Bool?
    /// If the device is hardware muted
    public let hardwareMute: Bool?

    private enum CodingKeys: String, CodingKey {
        case type
        case id
        case vendor
        case model
        case related
        case echoCancellation     = "echo_cancellation"
        case noiseSuppression     = "noise_suppression"
        case automaticGainControl = "automatic_gain_control"
        case hardwareMute         = "hardware_mute"
    }

    public init(
        type: DeviceType,
        id: String,
        vendor: Device.Vendor,
        model: Device.Model,
        related: [String] = [],
        echoCancellation: Bool? = nil,
        noiseSuppression: Bool? = nil,
        automaticGainControl: Bool? = nil,
        hardwareMute: Bool? = nil) {
        self.type = type
        self.id = id
        self.vendor = vendor
        self.model = model
        self.related = related
        self.echoCancellation = echoCancellation
        self.noiseSuppression = noiseSuppression
        self.automaticGainControl = automaticGainControl
        self.hardwareMute = hardwareMute
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#setcertifieddevices-vendor-object)
    public class Vendor: Codable {
        /// Name of the vendor
        public let name: String
        /// URL for the vendor
        public let url: String

        public init(name: String, url: String) {
            self.name = name
            self.url = url
        }
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#setcertifieddevices-model-object)
    public class Model: Codable {
        /// Name of the model
        public let name: String
        /// URL for the model
        public let url: String

        public init(name: String, url: String) {
            self.name = name
            self.url = url
        }
    }
}
