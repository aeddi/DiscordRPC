import Foundation

extension DiscordRPC {
    public func authorize(
        oAuth2Scopes: [OAuth2Scope],
        username: String? = nil,
        rpcToken: String? = nil) throws -> ResponseAuthorize {
        let nonce = generateNonce()
        let request = try RequestAuthorize(
            nonce: nonce,
            clientID: self.clientID,
            scopes: oAuth2Scopes,
            rpcToken: rpcToken,
            username: username
        )
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce, disableTimeout: true)
        return try ResponseAuthorize.from(data: response)
    }

    public func authorizeAsync(
        oAuth2Scopes: [OAuth2Scope],
        username: String? = nil,
        rpcToken: String? = nil) throws -> String {
        let nonce = generateNonce(async: true)
        let request = try RequestAuthorize(
            nonce: nonce,
            clientID: self.clientID,
            scopes: oAuth2Scopes,
            rpcToken: rpcToken,
            username: username
        )
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    public func authenticate(accessToken: String) throws -> ResponseAuthenticate {
        let nonce = generateNonce()
        let request = try RequestAuthenticate(nonce: nonce, accessToken: accessToken)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseAuthenticate.from(data: response)
    }

    public func authenticateAsync(accessToken: String) throws -> String {
        let nonce = generateNonce()
        let request = try RequestAuthenticate(nonce: nonce, accessToken: accessToken)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    public func subscribe(event: EventType, id: String? = nil) throws -> ResponseSubscribe {
        let nonce = generateNonce()
        let request = try RequestSubscribe(evt: event, nonce: nonce, id: id)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseSubscribe.from(data: response)
    }

    public func subscribeAsync(event: EventType, id: String? = nil) throws -> String {
        let nonce = generateNonce(async: true)
        let request = try RequestSubscribe(evt: event, nonce: nonce, id: id)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    public func unsubscribe(event: EventType, id: String? = nil) throws -> ResponseUnsubscribe {
        let nonce = generateNonce()
        let request = try RequestUnsubscribe(evt: event, nonce: nonce, id: id)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseUnsubscribe.from(data: response)
    }

    public func unsubscribeAsync(event: EventType, id: String? = nil) throws -> String {
        let nonce = generateNonce(async: true)
        let request = try RequestUnsubscribe(evt: event, nonce: nonce, id: id)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    // ---------------- //
    // Internal methods //
    // ---------------- //
    func handshake() throws {
        let request = try RequestHandshake(clientID: self.clientID)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .handshake)
        self.receive()
    }

    private func syncResponse(requestJSON: String, nonce: String, disableTimeout: Bool = false) throws -> Data {
        let semaphore = DispatchSemaphore(value: 0)
        var notification: Notification?
        var response: Data
        var error: EventErrorData?

        var observer: NSObjectProtocol?
        observer = self.cmdNotifCenter.addObserver(
            forName: NSNotification.Name(nonce),
            object: nil,
            queue: nil
        ) { notif in
            notification = notif
            semaphore.signal()
        }

        try self.send(requestJSON, .frame)

        if disableTimeout {
            semaphore.wait()
        } else {
            if semaphore.wait(timeout: .now() + .milliseconds(self.cmdTimeout)) == .timedOut {
                self.cmdNotifCenter.removeObserver(observer!)
                throw CommandError.timeout(timeout: self.cmdTimeout)
            }
        }
        self.cmdNotifCenter.removeObserver(observer!)

        do {
            let dict = notification!.userInfo! as NSDictionary
            // swiftlint:disable force_cast
            response = dict["data"] as! Data
            if dict["error"] as! Bool {
            // swiftlint:enable force_cast
                let event = try EventError.from(data: response)
                error = event.data
            }
        } catch {
            throw CommandError.responseMalformed(response: notification)
        }

        if let error = error { throw CommandError.failed(code: error.code, message: error.message) }

        return response
    }
}
