import Foundation

public class ResponseSetActivity: Frame {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder, withFixedCmdType: .setActivity, withFixedEventType: nil, withNonce: true)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseSetActivity {
        return try newJSONDecoder().decode(ResponseSetActivity.self, from: data)
    }
}
