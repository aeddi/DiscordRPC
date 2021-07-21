import Socket
import NotificationCenter

/// An object that manages an RPC connection to Discord through [UDS](https://en.wikipedia.org/wiki/Unix_domain_socket)
/// and allows to interact with the Discord API using Swift types and methods.
public class Session {
    /// Client ID of your Discord Application, set using `init(clientID:clientSecret:)`
    public let clientID: String
    /// Client Secret of your Discord Application, set using `init(clientID:clientSecret:)`
    public let clientSecret: String?
    /// Time limit in milliseconds for a sync command to get a response (default: 1000)
    public var cmdTimeout: Int = 1000
    /// If enabled, will print debug log including payload for each command request / response
    public var debugCommand: Bool = false
    /// If enabled, will print debug log including payload for each async command request / response
    public var debugCommandAsync: Bool = false
    /// If enabled, will print debug log including payload for each event received
    public var debugEvent: Bool = false

    var connectHandler:    ((_ session: Session, _ eventReady: EventReady) -> Void)?
    var disconnectHandler: ((_ session: Session, _ closeError: EventClose) -> Void)?
    var responseHandler:   ((_ session: Session, _ nonce: String, _ cmdType: CommandType, _ response: Data) -> Void)?
    var errorHandler:      ((_ session: Session, _ nonce: String, _ eventError: EventError) -> Void)?
    var eventHandler:      ((_ session: Session, _ eventType: EventType, _ event: Data) -> Void)?

    var socket: Socket?
    let rpcWorker: DispatchQueue
    let handlerWorker: DispatchQueue
    let cmdNotifCenter: NotificationCenter

    /// Creates a new `Session` instance using the given `clientID` and optionnal `clientSecret`.
    /// - Parameters:
    ///     - clientID: The Client ID of your Discord Application
    ///     - clientSecret: The Client Secret of your Discord Application (optional)
    /// - Note: To get the client ID and secret of your app, go to your [Discord Dashboard](https://discord.com/developers/applications) under OAuth2 section.
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
    /// - on success: an `EventReady` event on the `onConnect(handler:)`
    /// - on failure: an `EventClose` event on the `onDisconnect(handler:)`
    /// - Throws:
    ///     - `RPCError.appSandboxed`: If the current application is sandboxed
    ///     - `RPCError.socketCreation(error:)`: If the creation of the socket failed
    ///     - `RPCError.udsNotFound(path:)`: If unable to find the Discord UDS file
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
    /// Will trigger an `EventClose` with a `CloseEventCode.socketDisconnected` on `onDisconnect(handler:)`.
    public func disconnect() {
        self.closeSocket()
    }
}
