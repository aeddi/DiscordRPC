import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/rpc#getvoicesettings-get-voice-settings-response-structuret)
public class VoiceSettings: Codable {
    /// Input settings
    public let input: VoiceSettingsIO?
    /// Output  settings
    public let output: VoiceSettingsIO?
    /// Voice mode settings
    public let mode: VoiceSettingsMode?
    /// State of automatic gain control
    public let automaticGainControl: Bool?
    /// State of echo cancellation
    public let echoCancellation: Bool?
    /// State of noise suppression
    public let noiseSuppression: Bool?
    /// State of voice quality of service
    public let qos: Bool?
    /// State of silence warning notice
    public let silenceWarning: Bool?
    /// State of self-deafen
    public let deaf: Bool?
    /// State of self-mute
    public let mute: Bool?

    private enum CodingKeys: String, CodingKey {
        case input
        case output
        case mode
        case automaticGainControl = "automatic_gain_control"
        case echoCancellation     = "echo_cancellation"
        case noiseSuppression     = "noise_suppression"
        case qos
        case silenceWarning       = "silence_warning"
        case deaf
        case mute
    }

    public init(
        input: VoiceSettingsIO? = nil,
        output: VoiceSettingsIO? = nil,
        mode: VoiceSettingsMode? = nil,
        automaticGainControl: Bool? = nil,
        echoCancellation: Bool? = nil,
        noiseSuppression: Bool? = nil,
        qos: Bool? = nil,
        silenceWarning: Bool? = nil,
        deaf: Bool? = nil,
        mute: Bool? = nil) {
        self.input = input
        self.output = output
        self.mode = mode
        self.automaticGainControl = automaticGainControl
        self.echoCancellation = echoCancellation
        self.noiseSuppression = noiseSuppression
        self.qos = qos
        self.silenceWarning = silenceWarning
        self.deaf = deaf
        self.mute = mute
    }
}
