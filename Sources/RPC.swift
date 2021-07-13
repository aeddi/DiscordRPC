import Foundation
import Socket

extension DiscordRPC {
    func createSocket() throws {
        do {
            self.socket = try Socket.create(family: .unix, proto: .unix)
            try self.socket?.setBlocking(mode: true)
        } catch {
            throw RPCError.socketCreation(error: error)
        }
    }

    func closeSocket() {
        self.socket?.close()
        self.socket = nil
    }

    func send(_ msg: String, _ opCode: OPCode) throws {
        let payload = msg.data(using: .utf8)!
        var buffer = UnsafeMutableRawBufferPointer.allocate(
                byteCount: 8 + payload.count,
                alignment: MemoryLayout<UInt8>.alignment
        )
        defer { buffer.deallocate() }

        buffer.copyBytes(from: payload)
        buffer[8...] = buffer[..<payload.count]
        buffer.storeBytes(of: opCode.rawValue, as: UInt32.self)
        buffer.storeBytes(of: UInt32(payload.count), toByteOffset: 4, as: UInt32.self)

        try self.socket?.write(from: buffer.baseAddress!, bufSize: buffer.count)
    }

    func receive() {
        self.rpcWorker.async { [unowned self] in
            while true {
                guard let isConnected = self.socket?.isConnected, isConnected else {
                    self.disconnectHandler?(self, EventClose(code: .socketDisconnected, message: "Socket Disconnected"))
                    return
                }

                do {
                    let headerPtr = UnsafeMutablePointer<Int8>.allocate(capacity: 8)
                    let headerRawPtr = UnsafeRawPointer(headerPtr)
                    defer { free(headerPtr) }

                    var response = try self.socket?.read(into: headerPtr, bufSize: 8, truncate: true)
                    guard response! > 0 else {
                        logger.warning("Receive: header length is 0")
                        continue
                    }

                    let opValue = headerRawPtr.load(as: UInt32.self)
                    let length = headerRawPtr.load(fromByteOffset: 4, as: UInt32.self)
                    guard length > 0, let op = OPCode(rawValue: opValue) else {
                        logger.warning("Receive: opcode length is 0")
                        continue
                    }

                    let payloadPtr = UnsafeMutablePointer<Int8>.allocate(capacity: Int(length))
                    defer { free(payloadPtr) }

                    response = try self.socket?.read(into: payloadPtr, bufSize: Int(length), truncate: true)
                    guard response! > 0 else {
                        logger.warning("Receive: payload length is 0")
                        continue
                    }

                    let data = Data(bytes: UnsafeRawPointer(payloadPtr), count: Int(length))
                    self.handlePayload(op, data)
                } catch {
                    logger.error("Receive: failed with error: \(error.localizedDescription)")
                }
            }
        }
    }

    private func handlePayload(_ opCode: OPCode, _ data: Data) {
        do {
            switch opCode {
            case .close:
                self.closeSocket()
                let eventClose = try EventClose.from(data: data)
                self.handlerWorker.async { [unowned self] in
                    self.disconnectHandler?(self, eventClose)
                }

            case .ping:
                try? self.send(String(data: data, encoding: .utf8)!, .pong)

            case .frame:
                let frame = try Frame.from(data: data)
                if frame.cmd == .dispatch || frame.evt == .error {
                    handleEvent(data)
                } else {
                    handleResponse(data)
                }

            default:
                logger.warning("""
                    HandlePayload: received unexpected opcode (\(opCode.rawValue)) \
                    with data: \(String(data: data, encoding: .utf8) ?? "nil")
                """)
                return
            }
        } catch {
            logger.error("""
                HandlePayload: failed with error: \(error.localizedDescription); \
                and data: \(String(data: data, encoding: .utf8) ?? "nil")
            """)
        }
    }

    private func handleResponse(_ data: Data) {
        do {
            let frame = try Frame.from(data: data)
            if try isNonceAsync(nonce: frame.nonce!) {
                self.handlerWorker.async { [unowned self] in
                    self.responseHandler?(self, frame.nonce!, data)
                }
            } else {
                self.cmdNotifCenter.post(
                    name: NSNotification.Name(frame.nonce!),
                    object: nil,
                    userInfo: ["data": data, "error": false]
                )
            }
        } catch {
            logger.error("""
                HandleResponse: failed with error: \(error.localizedDescription); \
                and data: \(String(data: data, encoding: .utf8) ?? "nil")
            """)
        }
    }

    private func handleEvent(_ data: Data) {
        do {
            let frame = try Frame.from(data: data)

            switch frame.evt {
            case .ready:
                let readyEvent = try EventReady.from(data: data)
                self.handlerWorker.async { [unowned self] in
                    self.connectHandler?(self, readyEvent)
                }

            case .error:
                if try isNonceAsync(nonce: frame.nonce!) {
                    let err = try EventError.from(data: data)
                    self.handlerWorker.async { [unowned self] in
                        self.errorHandler?(self, frame.nonce!, err)
                    }
                } else {
                    self.cmdNotifCenter.post(
                        name: NSNotification.Name(frame.nonce!),
                        object: nil,
                        userInfo: ["data": data, "error": true]
                    )
                }

            default:
                self.handlerWorker.async { [unowned self] in
                    self.eventHandler?(self, frame.evt!, data)
                }
            }
        } catch {
            logger.error("""
                HandleEvent: failed with error: \(error.localizedDescription); \
                and data: \(String(data: data, encoding: .utf8) ?? "nil")
            """)
        }
    }
}
