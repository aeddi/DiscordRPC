import Foundation

public class ResponseSendActivityJoinInvite: Frame {
    required init(from decoder: Decoder) throws {
        try super.init(
            from: decoder,
            withFixedCmdType: .sendActivityJoinInvite,
            withFixedEventType: nil,
            withNonce: true
        )
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseSendActivityJoinInvite {
        return try newJSONDecoder().decode(ResponseSendActivityJoinInvite.self, from: data)
    }
}
