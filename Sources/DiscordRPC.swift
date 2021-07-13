import Socket
import NotificationCenter

/// An object that manages an RPC connection to Discord through [UDS](https://en.wikipedia.org/wiki/Unix_domain_socket)
/// and allows to interact with the Discord API using Swift types and methods.
public class DiscordRPC {
    /// Client ID of your Discord Application, set during `init()`
    public let clientID: String
    /// Client Secret of your Discord Application, set during `init()`
    public let clientSecret: String?
    /// Time limit in milliseconds for a sync command to get a response (default: 1000)
    public var cmdTimeout = 1000

    var connectHandler:    ((_ rpc: DiscordRPC, _ eventReady: EventReady) -> Void)?
    var disconnectHandler: ((_ rpc: DiscordRPC, _ closeError: EventClose) -> Void)?
    var responseHandler:   ((_ rpc: DiscordRPC, _ nonce: String, _ commandType: CommandType, _ response: Data) -> Void)?
    var errorHandler:      ((_ rpc: DiscordRPC, _ nonce: String, _ eventError: EventError) -> Void)?
    var eventHandler:      ((_ rpc: DiscordRPC, _ eventType: EventType, _ event: Data) -> Void)?

    var socket: Socket?
    let rpcWorker: DispatchQueue
    let handlerWorker: DispatchQueue
    let cmdNotifCenter: NotificationCenter

    /// Creates a new DiscordRPC instance using the given `clientID` and optionnal `clientSecret`.
    /// To get these, go to your [Discord Dashboard](https://discord.com/developers/applications) under OAuth2 section.
    /// - Parameters:
    ///     - `clientID`: The Client ID of your Discord Application
    ///     - `clientSecret`: The Client Secret of your Discord Application
    public init(clientID: String, clientSecret: String? = nil) {
        self.clientID = clientID
        self.clientSecret = clientSecret

        self.rpcWorker = DispatchQueue(
            label: "discord.rpc.worker.\(ProcessInfo.processInfo.processIdentifier)",
            qos: .userInitiated
        )
        self.handlerWorker = DispatchQueue(
            label: "discord.handler.worker.\(ProcessInfo.processInfo.processIdentifier)",
            qos: .userInitiated
        )
        self.cmdNotifCenter = NotificationCenter()
    }

    /// Init connection to the Discord RPC API, this will trigger:
    ///     - on success:  an `EventReady` event on the `connectHandler`
    ///     - on failure: an `EventClose` event  on the `disconnectHandler`
    /// - Throws:
    ///     - `RPCError.appSandboxed`: If the current application is sandboxed
    ///     - `RPCError.socketCreation`: If the creation of the socket failed
    ///     - `RPCError.udsNotFound`: If unable to find the Discord UDS file
    public func connect() throws {
        if ProcessInfo.processInfo.environment["APP_SANDBOX_CONTAINER_ID"] != nil {
            throw RPCError.appSandboxed
        }
        try self.createSocket()

        let path = NSTemporaryDirectory()
        for suffix in udsSuffixRange {
            try? self.socket!.connect(to: "\(path)/discord-ipc-\(suffix)")

            guard !self.socket!.isConnected else {
                do {
                    try self.handshake()
                    return
                } catch {
                    self.closeSocket()
                    throw error
                }
            }
        }

        throw RPCError.udsNotFound(path: path)
    }

    /// Disconnect from the Discord RPC API.
    public func disconnect() {
        self.closeSocket()
    }
}
