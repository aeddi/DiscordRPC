import Foundation
import os

let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DiscordRPC", category: "discord-rpc")

extension Session {
    enum CommandDirection: String {
        case request
        case response
    }

    func logDebugCommand(commandType: CommandType, direction: CommandDirection, nonce: String, content: Data?) {
        var async: Bool = false

        if let asyncFromNonce = try? isNonceAsync(nonce: nonce) {
            async = asyncFromNonce
        }

        if (!async && !debugCommand) || (async && !debugCommandAsync) { return }

        var contentString: String
        if let content = content {
            contentString = content.tryPrettyPrintedJSONString
        } else {
            contentString = "nil"
        }

        logger.debug("""
        \nCommand: \(commandType.rawValue),
        Direction: \(direction.rawValue),
        Async: \(async),
        Nonce: \(nonce),
        Content \(contentString)
        """)
    }

    func logDebugEvent(eventType: EventType, content: Data?) {
        if !debugEvent { return }

        var contentString: String
        if let content = content {
            contentString = content.tryPrettyPrintedJSONString
        } else {
            contentString = "nil"
        }

        logger.debug("""
        \nEvent: \(eventType.rawValue),
        Content \(contentString)
        """)
    }
}

extension Data {
    var tryPrettyPrintedJSONString: String {
        guard let pretty = prettyPrintedJSONString else {
            return "(Raw): \(String(data: self, encoding: .utf8) ?? "nil")"
        }

        return "(JSON): \(pretty)"
    }

    // From https://gist.github.com/cprovatas/5c9f51813bc784ef1d7fcbfb89de74fe
    private var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else { return nil }

        return prettyPrintedString
    }
}
