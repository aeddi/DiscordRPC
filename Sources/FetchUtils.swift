import Foundation
import AppKit

extension DiscordRPC {
    /// Fetch from Discord servers the avatar of an user as a raw `Data`
    /// - Parameters:
    ///     - id: The ID of the user
    ///     - avatar: The avatar ID of the user
    ///     - timeout: The time limit in milliseconds for the request to finish (optional, default: 10000)
    /// - Returns: A raw `Data` of the user avatar
    /// - Throws:
    ///     - `HTTPError.timeout(timeout:)`: If the time limit is exceeded
    ///     - `HTTPError.failed(code:error:)`: If the request failed
    public func fetchAccessToken(code: String, timeout: Int? = 10000, redirectURI: String = "") throws -> AccessToken {
        let response = try httpRequest(
            endpoint: "https://discord.com/api/oauth2/token",
            method: "POST",
            timeout: timeout,
            headers: ["Authorization": "Bearer \("")"],
            parameters: [
                "client_id": self.clientID,
                "client_secret": self.clientSecret!,
                "code": code,
                "grant_type": "authorization_code",
                "redirect_uri": redirectURI
            ])

        return try AccessToken.from(data: response)
    }

    /// Fetch from Discord servers the avatar of an user as a raw `Data`.
    /// - Parameters:
    ///     - id: The ID of the user
    ///     - avatar: The avatar ID of the user
    ///     - timeout: The time limit in milliseconds for the request to finish (optional, default: 10000)
    /// - Returns: A raw `Data` of the user avatar
    /// - Throws:
    ///     - `HTTPError.timeout(timeout:)`: If the time limit is exceeded
    ///     - `HTTPError.failed(code:error:)`: If the request failed
    /// - Warning: Seems to be outdated, see: https://github.com/discord/discord-api-docs/issues/2700#issuecomment-797700709
    public func fetchRPCToken(timeout: Int? = 10000) throws -> RPCToken {
        let response = try httpRequest(
            endpoint: "https://discord.com/api/oauth2/token/rpc",
            method: "POST",
            timeout: timeout,
            headers: ["Authorization": "Bearer \("")"],
            parameters: [
                "client_id": self.clientID,
                "client_secret": self.clientSecret!
            ])

        return try RPCToken.from(data: response)
    }
}

/// Fetch from Discord servers the avatar of an user as a raw `Data`.
/// - Parameters:
///     - id: The ID of the user
///     - avatar: The avatar ID of the user
///     - timeout: The time limit in milliseconds for the request to finish (optional, default: 10000)
/// - Returns: A raw `Data` of the user avatar
/// - Throws:
///     - `HTTPError.timeout(timeout:)`: If the time limit is exceeded
///     - `HTTPError.failed(code:error:)`: If the request failed
public func fetchUserAvatarData(id: String, avatar: String, timeout: Int? = 10000) throws -> Data {
    return try httpRequest(
        endpoint: "https://cdn.discordapp.com/avatars/\(id)/\(avatar).png",
        method: "GET",
        timeout: timeout
    )
}

/// Fetch from Discord servers the avatar of an user as an `NSImage`.
/// - Parameters:
///     - id: The ID of the user
///     - avatar: The avatar ID of the user
///     - timeout: The time limit in milliseconds for the request to finish (optional, default: 10000)
/// - Returns: An `NSImage` of the user avatar
/// - Throws:
///     - `HTTPError.timeout(timeout:)`: If the time limit is exceeded
///     - `HTTPError.failed(code:error:)`: If the request failed
public func fetchUserAvatarImage(id: String, avatar: String, timeout: Int? = 10000) throws -> NSImage {
    return NSImage(data: try fetchUserAvatarData(id: id, avatar: avatar, timeout: timeout))!
}

// ---------------- //
// Internal methods //
// ---------------- //
func httpRequest(
    endpoint: String,
    method: String,
    timeout: Int?,
    headers: [String: String] = [:],
    parameters: [String: Any] = [:]) throws -> Data {
    let semaphore = DispatchSemaphore(value: 0)
    var response: Data?
    var error: Error?
    var request = URLRequest(url: URL(string: endpoint)!)

    request.httpMethod = method
    for (key, value) in headers {
        request.setValue(value, forHTTPHeaderField: key)
    }
    request.httpBody = parameters.percentEncoded()

    let task = URLSession.shared.dataTask(with: request) { data, resp, err in
        defer { semaphore.signal() }

        guard let data = data, err == nil && (200 ... 299) ~= ((resp as? HTTPURLResponse)?.statusCode ?? 0) else {
            error = HTTPError.failed(code: (resp as? HTTPURLResponse)?.statusCode, error: err)
            return
        }

        response = data
    }
    task.resume()

    if let timeout = timeout,
       semaphore.wait(timeout: .now() + .milliseconds(timeout)) == .timedOut {
        throw HTTPError.timeout(timeout: timeout)
    } else if timeout == nil {
        semaphore.wait()
    }

    if let error = error { throw error }

    return response!
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
