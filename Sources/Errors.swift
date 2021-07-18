import Foundation

/// Errors that can occurs during RPC operation.
public enum RPCError: Error {
    /// Error throwed by `DiscordRPC.init()` if the app is sandboxed.
    case appSandboxed
    /// Error throwed by `DiscordRPC.connect()` if the socket creation failed.
    case socketCreation(error: Error?)
    /// Error throwed by `DiscordRPC.connect()` if the Discord UDS file was not found.
    case udsNotFound(path: String)
}
extension RPCError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .appSandboxed:
            return NSLocalizedString(
                "Can't connect using UDS RPC within a sandboxed app",
                comment: ""
            )
        case .socketCreation(let error):
            return NSLocalizedString(
                "Socket creation failed\(error != nil ? ": \(error!.localizedDescription)" : "")",
                comment: ""
            )
        case .udsNotFound(let path):
            return NSLocalizedString(
                "Discord Unix Domain Socket not found in path: \(path)",
                comment: ""
            )
        }
    }
}

/// Errors that can occurs during HTTP request.
public enum HTTPError: Error {
    /// Error throwed if the time limit for a request is exceeded.
    case timeout(timeout: Int)
    /// Error throwed if a request failed.
    case failed(code: Int?, error: Error?)
}
extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .timeout(let timeout):
            return NSLocalizedString(
                "Response took to much time and request has timeout (\(timeout)ms)",
                comment: ""
            )
        case .failed(let code, let error):
            return NSLocalizedString(
                "Request returned an error (\(code ?? 0))\(error != nil ? ": \(error!.localizedDescription)" : "")",
                comment: ""
            )
        }
    }
}

/// Errors that can occurs during nonce validation.
public enum NonceError: Error {
    /// Errors throwed if a nonce is invalid.
    case invalid(nonce: String)
}
extension NonceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalid(let nonce):
            return NSLocalizedString(
                "Invalid nonce (\(nonce)) not an UUID prefixed by either 'async;' or 'sync;'",
                comment: ""
            )
        }
    }
}

/// Errors that can occurs during call to an RPC command.
public enum CommandError: Error {
    /// Error throwed if the time limit for a sync command is exceeded.
    case timeout(timeout: Int)
    /// Error throwed if the response received by a sync command is malformed.
    case responseMalformed(response: Notification?)
    /// Error throwed if a sync command failed.
    case failed(code: ErrorCode, message: String)
    /// Errors throwed if the passed parameters are invalid.
    case invalidParameters(reason: String)
}
extension CommandError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .timeout(let timeout):
            return NSLocalizedString(
                "Response took to much time and command has timeout (\(timeout)ms)",
                comment: ""
            )
        case .responseMalformed(let response):
            return NSLocalizedString(
                "Command returned a malformed response: \(String(describing: response!.userInfo))",
                comment: ""
            )
        case .failed(let code, let message):
            return NSLocalizedString(
                "Command returned an error (\(code)): \(message)",
                comment: ""
            )
        case .invalidParameters(let reason):
            return NSLocalizedString(
                "Invalid parameters: \(reason)",
                comment: ""
            )
        }
    }
}
