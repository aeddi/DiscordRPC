import Foundation

public class ResponseCloseActivityRequest: Frame {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder, withFixedCmdType: .closeActivityRequest, withFixedEventType: nil, withNonce: true)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseCloseActivityRequest {
        return try newJSONDecoder().decode(ResponseCloseActivityRequest.self, from: data)
    }
}
