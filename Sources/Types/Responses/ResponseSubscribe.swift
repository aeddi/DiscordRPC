import Foundation

public class ResponseSubscribe: Frame {
    public let data: ResponseSubscribeData

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(ResponseSubscribeData.self, forKey: .data)
        try super.init(from: decoder, withFixedCmdType: .subscribe, withFixedEventType: nil, withNonce: true)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }

    public override class func from(data: Data) throws -> ResponseSubscribe {
        return try newJSONDecoder().decode(ResponseSubscribe.self, from: data)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString() throws -> String {
        return String(data: try self.jsonData(), encoding: .utf8)!
    }
}

public class ResponseSubscribeData: Codable {
    public let evt: EventType
}
