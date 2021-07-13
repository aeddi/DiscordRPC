import Foundation

public enum RPCError: Error {
    case appSandboxed
    case socketCreation(error: Error?)
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

public enum HTTPError: Error {
    case timeout(timeout: Int)
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

public enum NonceError: Error {
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

public enum RequestError: Error {
    case invalidParameters(reason: String)
}
extension RequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidParameters(let reason):
            return NSLocalizedString(
                "Invalid parameters: \(reason)",
                comment: ""
            )
        }
    }
}

public enum CommandError: Error {
    case timeout(timeout: Int)
    case responseMalformed(response: Notification?)
    case failed(code: ErrorCode, message: String)
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
        }
    }
}
