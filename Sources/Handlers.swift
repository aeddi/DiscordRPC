import Foundation

extension DiscordRPC {
    /// Setter for the `onConnect` handler that will receive an event on `connect()` success.
    /// - Parameter handler:
    ///     A callback that take as parameters:
    ///     - a reference to the related `DiscordRPC` instance
    ///     - an `EventReady`
    public func onConnect(
        handler: @escaping (_ rpc: DiscordRPC, _ eventReady: EventReady) -> Void
    ) {
        self.connectHandler = handler
    }

    /// Setter for the `onDisconnect` handler that will receive an event on `disconnect()` or
    /// if the Discord Client disconnects.
    /// - Parameter handler:
    ///     A callback that take as parameters:
    ///     - a reference to the related `DiscordRPC` instance
    ///     - an `EventClose`
    public func onDisconnect(
        handler: @escaping (_ rpc: DiscordRPC, _ closeError: EventClose) -> Void
    ) {
        self.disconnectHandler = handler
    }

    /// Setter for the `onResponse` handler that will receive a response from an async command.
    /// - Parameter handler:
    ///     A callback that take as parameters:
    ///     - a reference to the related `DiscordRPC` instance
    ///     - a `nonce` that can be used to determine from wich call this response comes from, knowing that every call to an async command will return a nonce
    ///     - a `CommandType` that can be used to determine from wich command type this response comes from
    ///     - a raw `response` that can be casted using the `from(data:)` method of the class corresponding to the `CommandType`
    public func onResponse(
        handler: @escaping (_ rpc: DiscordRPC, _ nonce: String, _ commandType: CommandType, _ response: Data) -> Void
    ) {
        self.responseHandler = handler
    }

    /// Setter for the `onError` handler that will receive an error from an async command.
    /// - Parameter handler:
    ///     A callback that take as parameters:
    ///     - a reference to the related `DiscordRPC` instance
    ///     - a `nonce` that can be used to determine from wich call this error comes from, knowing that every call to an async command
    ///     will return a nonce
    ///     - an `EventError`
    public func onError(
        handler: @escaping (_ rpc: DiscordRPC, _ nonce: String, _ eventError: EventError) -> Void
    ) {
        self.errorHandler = handler
    }

    /// Setter for the `onEvent` handler that will receive an event from a subscription.
    /// - Parameter handler:
    ///     A callback that take as parameters:
    ///     - a reference to the related `DiscordRPC` instance
    ///     - a `CommandType` that can be used to determine from wich type the received event is
    ///     - a raw `event` that can be casted using the `from(data:)` method of the class corresponding to the `EventType`
    public func onEvent(
        handler: @escaping (_ rpc: DiscordRPC, _ eventType: EventType, _ event: Data) -> Void
    ) {
        self.eventHandler = handler
    }
}
