import Foundation

public class RPCToken: Codable {
    public let rpcToken: String

    private enum CodingKeys: String, CodingKey {
        case rpcToken = "rpc_token"
    }

    public class func from(data: Data) throws -> RPCToken {
        return try newJSONDecoder().decode(RPCToken.self, from: data)
    }

    public func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    public func jsonString() throws -> String {
        return String(data: try self.jsonData(), encoding: .utf8)!
    }
}
