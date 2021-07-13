import Foundation

extension DiscordRPC {
    public func onConnect(
        handler: @escaping (_ rpc: DiscordRPC, _ eventReady: EventReady) -> Void
    ) {
        self.connectHandler = handler
    }

    public func onDisconnect(
        handler: @escaping (_ rpc: DiscordRPC, _ closeError: EventClose) -> Void
    ) {
        self.disconnectHandler = handler
    }

    public func onResponse(
        handler: @escaping (_ rpc: DiscordRPC, _ nonce: String, _ commandType: CommandType, _ response: Data) -> Void
    ) {
        self.responseHandler = handler
    }

    public func onError(
        handler: @escaping (_ rpc: DiscordRPC, _ nonce: String, _ eventError: EventError) -> Void
    ) {
        self.errorHandler = handler
    }

    public func onEvent(
        handler: @escaping (_ rpc: DiscordRPC, _ eventType: EventType, _ event: Data) -> Void
    ) {
        self.eventHandler = handler
    }
}
