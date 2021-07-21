import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#getvoicesettings-voice-settings-mode-object)
public class VoiceSettingsMode: Codable {
    /// Voice setting mode type (can be `PUSH_TO_TALK` or `VOICE_ACTIVITY`)
    public let type: VoiceSettingsModeType?
    /// Voice activity threshold automatically sets its threshold
    public let autoThreshold: Bool?
    /// Threshold for voice activity (in dB) (min: -100, max: 0)
    public let threshold: Float?
    /// Shortcut key combos for PTT
    public let shortcut: ShorcutKeyCombo?
    /// The PTT release delay (in ms) (min: 0, max: 2000)
    public let delay: Float?

    private enum CodingKeys: String, CodingKey {
        case type
        case autoThreshold = "auto_threshold"
        case threshold
        case shortcut
        case delay
    }

    public init(
        type: VoiceSettingsModeType? = nil,
        autoThreshold: Bool? = nil,
        threshold: Float? = nil,
        shortcut: ShorcutKeyCombo? = nil,
        delay: Float? = nil)
    {
        self.type = type
        self.autoThreshold = autoThreshold
        self.threshold = threshold
        self.shortcut = shortcut
        self.delay = delay
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#getvoicesettings-shortcut-key-combo-object)
    public class ShorcutKeyCombo: Codable {
        /// See key types
        public let type: KeyType?
        /// Key code
        public let code: Int?
        /// Key name
        public let name: String?

        public init(type: KeyType? = nil, code: Int? = nil, name: String? = nil) {
            self.type = type
            self.code = code
            self.name = name
        }
    }
}
