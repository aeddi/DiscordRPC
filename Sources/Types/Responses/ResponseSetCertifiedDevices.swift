import Foundation

public class ResponseSetCertifiedDevices: Frame {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder, withFixedCmdType: .setCertifiedDevices, withFixedEventType: nil, withNonce: true)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseSetCertifiedDevices {
        return try newJSONDecoder().decode(ResponseSetCertifiedDevices.self, from: data)
    }
}
