import Foundation

extension DiscordRPC {
    /// Authorize a new client with your app.
    /// - Parameters:
    ///     - oAuth2Scopes: OAuth2 scopes to authorize
    ///     - username: Username to create a guest account with if the user does not have Discord
    ///     - rpcToken: One-time use RPC token
    /// - Returns: A `ResponseAuthorize` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func authorize(
        oAuth2Scopes: [OAuth2Scope],
        username: String? = nil,
        rpcToken: String? = nil) throws -> ResponseAuthorize {
        let nonce = generateNonce()
        let request = RequestAuthorize(
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

    /// Authorize a new client with your app asynchronously.
    /// - Parameters:
    ///     - oAuth2Scopes: OAuth2 scopes to authorize
    ///     - username: Username to create a guest account with if the user does not have Discord
    ///     - rpcToken: One-time use RPC token
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func authorizeAsync(
        oAuth2Scopes: [OAuth2Scope],
        username: String? = nil,
        rpcToken: String? = nil) throws -> String {
        let nonce = generateNonce(async: true)
        let request = RequestAuthorize(
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

    /// Authenticate an existing client with your app.
    /// - Parameter accessToken: OAuth2 access token obtained with `fetchAccessToken(code:timeout:redirectURI:)`
    /// - Returns: A `ResponseAuthenticate` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func authenticate(accessToken: String) throws -> ResponseAuthenticate {
        let nonce = generateNonce()
        let request = RequestAuthenticate(nonce: nonce, accessToken: accessToken)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseAuthenticate.from(data: response)
    }

    /// Authenticate an existing client with your app asynchronously.
    /// - Parameter accessToken: OAuth2 access token obtained with `fetchAccessToken(code:timeout:redirectURI:)`
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func authenticateAsync(accessToken: String) throws -> String {
        let nonce = generateNonce()
        let request = RequestAuthenticate(nonce: nonce, accessToken: accessToken)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Retrieve a list of guilds from the client.
    /// - Returns: A `ResponseGetGuilds` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func getGuilds() throws -> ResponseGetGuilds {
        let nonce = generateNonce()
        let request = RequestGetGuilds(nonce: nonce)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseGetGuilds.from(data: response)
    }

    /// Retrieve a list of guilds from the client asynchronously.
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func getGuildsAsync() throws -> String {
        let nonce = generateNonce()
        let request = RequestGetGuilds(nonce: nonce)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Retrieve guild information from the client.
    /// - Parameters:
    ///     - guildID: ID of the guild to get
    ///     - timeout: Asynchronously get guild with time to wait before timing out
    /// - Returns: A `ResponseGetGuild` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func getGuild(guildID: String, timeout: Int) throws -> ResponseGetGuild {
        let nonce = generateNonce()
        let request = RequestGetGuild(nonce: nonce, guildID: guildID, timeout: timeout)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseGetGuild.from(data: response)
    }

    /// Retrieve guild information from the client asynchronously.
    /// - Parameters:
    ///     - guildID: ID of the guild to get
    ///     - timeout: Asynchronously get guild with time to wait before timing out
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func getGuildAsync(guildID: String, timeout: Int) throws -> String {
        let nonce = generateNonce()
        let request = RequestGetGuild(nonce: nonce, guildID: guildID, timeout: timeout)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Retrieve channel information from the client.
    /// - Parameter channelID: ID of the channel to get
    /// - Returns: A `ResponseGetChannel` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func getChannel(channelID: String) throws -> ResponseGetChannel {
        let nonce = generateNonce()
        let request = RequestGetChannel(nonce: nonce, channelID: channelID)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseGetChannel.from(data: response)
    }

    /// Retrieve channel information from the client asynchronously.
    /// - Parameter channelID: ID of the channel to get
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func getChannelAsync(channelID: String) throws -> String {
        let nonce = generateNonce()
        let request = RequestGetChannel(nonce: nonce, channelID: channelID)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Retrieve a list of channels for a guild from the client.
    /// - Parameter guildID: ID of the guild to get channels for
    /// - Returns: A `ResponseGetChannels` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func getChannels(guildID: String) throws -> ResponseGetChannels {
        let nonce = generateNonce()
        let request = RequestGetChannels(nonce: nonce, guildID: guildID)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseGetChannels.from(data: response)
    }

    /// Retrieve a list of channels for a guild from the client asynchronously.
    /// - Parameter guildID: ID of the guild to get channels for
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func getChannelsAsync(guildID: String) throws -> String {
        let nonce = generateNonce()
        let request = RequestGetChannels(nonce: nonce, guildID: guildID)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Change voice settings of users in voice channels.
    /// - Parameters:
    ///     - userID: The ID of the user to change the voice settings of
    ///     - pan: Set the pan of the user
    ///     - volume: Set the volume of user (defaults to 100, min 0, max 200)
    ///     - mute: Set the mute state of the user
    /// - Returns: A `ResponseSetUserVoiceSettings` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func setUserVoiceSettings(
        userID: String,
        pan: Pan?,
        volume: Int?,
        mute: Bool?) throws -> ResponseSetUserVoiceSettings {
        let nonce = generateNonce()
        let request = RequestSetUserVoiceSettings(
            nonce: nonce,
            userID: userID,
            pan: pan,
            volume: volume,
            mute: mute
        )
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseSetUserVoiceSettings.from(data: response)
    }

    /// Change voice settings of users in voice channels asynchronously.
    /// - Parameters:
    ///     - userID: The ID of the user to change the voice settings of
    ///     - pan: Set the pan of the user
    ///     - volume: Set the volume of user (defaults to 100, min 0, max 200)
    ///     - mute: Set the mute state of the user
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func setUserVoiceSettingsAsync(userID: String, pan: Pan?, volume: Int?, mute: Bool?) throws -> String {
        let nonce = generateNonce()
        let request = RequestSetUserVoiceSettings(
            nonce: nonce,
            userID: userID,
            pan: pan,
            volume: volume,
            mute: mute
        )
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Join or leave a voice channel, group DM, or DM.
    /// - Parameters:
    ///     - channelID: Channel id to join (or `nil` to leave)
    ///     - timeout: Asynchronously join channel with time to wait before timing out
    ///     - force: Forces a user to join a voice channel
    /// - Returns: A `ResponseSelectVoiceChannel` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func selectVoiceChannel(channelID: String?, timeout: Int, force: Bool) throws -> ResponseSelectVoiceChannel {
        let nonce = generateNonce()
        let request = RequestSelectVoiceChannel(nonce: nonce, channelID: channelID, timeout: timeout, force: force)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseSelectVoiceChannel.from(data: response)
    }

    /// Join or leave a voice channel, group DM, or DM asynchronously.
    /// - Parameters:
    ///     - channelID: Channel id to join (or `nil` to leave)
    ///     - timeout: Asynchronously join channel with time to wait before timing out
    ///     - force: Forces a user to join a voice channel
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func selectVoiceChannelAsync(channelID: String?, timeout: Int, force: Bool) throws -> String {
        let nonce = generateNonce()
        let request = RequestSelectVoiceChannel(nonce: nonce, channelID: channelID, timeout: timeout, force: force)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Get the current voice channel the client is in.
    /// - Returns: A `ResponseGetSelectedVoiceChannel` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func getSelectedVoiceChannel() throws -> ResponseGetSelectedVoiceChannel {
        let nonce = generateNonce()
        let request = RequestGetSelectedVoiceChannel(nonce: nonce)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseGetSelectedVoiceChannel.from(data: response)
    }

    /// Get the current voice channel the client is in asynchronously.
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func getSelectedVoiceChannelAsync() throws -> String {
        let nonce = generateNonce()
        let request = RequestGetSelectedVoiceChannel(nonce: nonce)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Join or leave a text channel, group DM, or DM.
    /// - Parameters:
    ///     - channelID: Channel id to join (or `nil` to leave)
    ///     - timeout: Asynchronously join channel with time to wait before timing out
    /// - Returns: A `ResponseSelectTextChannel` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func selectTextChannel(channelID: String, timeout: Int) throws -> ResponseSelectTextChannel {
        let nonce = generateNonce()
        let request = RequestSelectTextChannel(nonce: nonce, channelID: channelID, timeout: timeout)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseSelectTextChannel.from(data: response)
    }

    /// Join or leave a text channel, group DM, or DM asynchronously.
    /// - Parameters:
    ///     - channelID: Channel id to join (or `nil` to leave)
    ///     - timeout: Asynchronously join channel with time to wait before timing out
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func selectTextChannelAsync(channelID: String, timeout: Int) throws -> String {
        let nonce = generateNonce()
        let request = RequestSelectTextChannel(nonce: nonce, channelID: channelID, timeout: timeout)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Retrieve the client's voice settings.
    /// - Returns: A `ResponseGetVoiceSettings` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func getVoiceSettings() throws -> ResponseGetVoiceSettings {
        let nonce = generateNonce()
        let request = RequestGetVoiceSettings(nonce: nonce)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseGetVoiceSettings.from(data: response)
    }

    /// Retrieve the client's voice settings asynchronously.
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func getVoiceSettingsAsync(voiceSettings: VoiceSettings) throws -> String {
        let nonce = generateNonce()
        let request = RequestGetVoiceSettings(nonce: nonce)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Set the client's voice settings.
    /// - Parameter voiceSettings: Voice settings to set (all fields are optional, only passed ones are updated)
    /// - Returns: A `ResponseSetVoiceSettings` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func setVoiceSettings(voiceSettings: VoiceSettings) throws -> ResponseSetVoiceSettings {
        let nonce = generateNonce()
        let request = RequestSetVoiceSettings(nonce: nonce, voiceSettings: voiceSettings)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseSetVoiceSettings.from(data: response)
    }

    /// Set the client's voice settings asynchronously.
    /// - Parameter voiceSettings: Voice settings to set (all fields are optional, only passed ones are updated)
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func setVoiceSettingsAsync(voiceSettings: VoiceSettings) throws -> String {
        let nonce = generateNonce()
        let request = RequestSetVoiceSettings(nonce: nonce, voiceSettings: voiceSettings)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Send info about certified hardware devices.
    /// - Parameter devices: A list of devices for your manufacturer, in order of priority
    /// - Returns: A `ResponseSetCertifiedDevices` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func setCertifiedDevices(devices: [Device]) throws -> ResponseSetCertifiedDevices {
        let nonce = generateNonce()
        let request = RequestSetCertifiedDevices(nonce: nonce, devices: devices)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseSetCertifiedDevices.from(data: response)
    }

    /// Send info about certified hardware devices asynchronously.
    /// - Parameter devices: A list of devices for your manufacturer, in order of priority
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func setCertifiedDevicesAsync(devices: [Device]) throws -> String {
        let nonce = generateNonce()
        let request = RequestSetCertifiedDevices(nonce: nonce, devices: devices)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Update a user's Rich Presence.
    /// - Parameters:
    ///     - pid: The application's process ID
    ///     - activity: The Rich Presence to assign to the user
    /// - Returns: A `ResponseSetActivity` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func setActivity(pid: Int, activity: Activity) throws -> ResponseSetActivity {
        let nonce = generateNonce()
        let request = RequestSetActivity(nonce: nonce, pid: pid, activity: activity)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseSetActivity.from(data: response)
    }

    /// Update a user's Rich Presence asynchronously.
    /// - Parameters:
    ///     - pid: The application's process ID
    ///     - activity: The Rich Presence to assign to the user
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func setActivityAsync(pid: Int, activity: Activity) throws -> String {
        let nonce = generateNonce()
        let request = RequestSetActivity(nonce: nonce, pid: pid, activity: activity)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Consent to a Rich Presence Ask to Join request.
    /// - Parameter userID: The ID of the requesting user
    /// - Returns: A `ResponseSendActivityJoinInvite` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func sendActivityJoinInvite(userID: String) throws -> ResponseSendActivityJoinInvite {
        let nonce = generateNonce()
        let request = RequestSendActivityJoinInvite(nonce: nonce, userID: userID)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseSendActivityJoinInvite.from(data: response)
    }

    /// Consent to a Rich Presence Ask to Join request asynchronously.
    /// - Parameter userID: The ID of the requesting user
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func sendActivityJoinInviteAsync(userID: String) throws -> String {
        let nonce = generateNonce()
        let request = RequestSendActivityJoinInvite(nonce: nonce, userID: userID)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Reject a Rich Presence Ask to Join request.
    /// - Parameter userID: The ID of the requesting user
    /// - Returns: A `ResponseCloseActivityRequest` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func closeActivityRequest(userID: String) throws -> ResponseCloseActivityRequest {
        let nonce = generateNonce()
        let request = RequestCloseActivityRequest(nonce: nonce, userID: userID)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseCloseActivityRequest.from(data: response)
    }

    /// Reject a Rich Presence Ask to Join request asynchronously.
    /// - Parameter userID: The ID of the requesting user
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed 
    ///     - `EncodingError`: If the request encoding failed
    public func closeActivityRequestAsync(userID: String) throws -> String {
        let nonce = generateNonce()
        let request = RequestCloseActivityRequest(nonce: nonce, userID: userID)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Subscribe to an RPC event.
    /// - Parameters:
    ///     - event: Event name to subscribe to
    ///     - id:
    ///         - A channel ID is required for this event types: `EventType.voiceStateCreate`, `EventType.voiceStateUpdate`,
    ///         `EventType.voiceStateDelete`, `EventType.messageCreate`, `EventType.messageUpdate`,
    ///         `EventType.messageDelete`, `EventType.speakingStart`, `EventType.speakingStop`
    ///         - A guild ID is required for this event type: `EventType.guildStatus`
    /// - Returns: A `ResponseSubscribe` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `CommandError.invalidParameters(reason:)`: If the ID is not passed according to the event type
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func subscribe(event: EventType, id: String? = nil) throws -> ResponseSubscribe {
        let nonce = generateNonce()
        let request = try RequestSubscribe(evt: event, nonce: nonce, id: id)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseSubscribe.from(data: response)
    }

    /// Subscribe to an RPC event asynchronously.
    /// - Parameters:
    ///     - event: Event name to subscribe to
    ///     - id:
    ///         - A channel ID is required for this event types: `EventType.voiceStateCreate`, `EventType.voiceStateUpdate`,
    ///         `EventType.voiceStateDelete`, `EventType.messageCreate`, `EventType.messageUpdate`,
    ///         `EventType.messageDelete`, `EventType.speakingStart`, `EventType.speakingStop`
    ///         - A guild ID is required for this event type: `EventType.guildStatus`
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `CommandError.invalidParameters(reason:)`: If the ID is not passed according to the event type
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    public func subscribeAsync(event: EventType, id: String? = nil) throws -> String {
        let nonce = generateNonce(async: true)
        let request = try RequestSubscribe(evt: event, nonce: nonce, id: id)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .frame)
        return nonce
    }

    /// Unsubscribe from an RPC event.
    /// - Parameters:
    ///     - event: Event name to subscribe to
    ///     - id:
    ///         - A channel ID is required for this event types: `EventType.voiceStateCreate`, `EventType.voiceStateUpdate`,
    ///         `EventType.voiceStateDelete`, `EventType.messageCreate`, `EventType.messageUpdate`,
    ///         `EventType.messageDelete`, `EventType.speakingStart`, `EventType.speakingStop`
    ///         - A guild ID is required for this event type: `EventType.guildStatus`
    /// - Returns: A `ResponseUnsubscribe` object
    /// - Throws:
    ///     - `CommandError.timeout(timeout:)`: If the command timed out
    ///     - `CommandError.responseMalformed(response:)`: If the command response is malformed
    ///     - `CommandError.failed(code:message:)`: If the command failed
    ///     - `CommandError.invalidParameters(reason:)`: If the ID is not passed according to the event type
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed
    ///     - `EncodingError`: If the request encoding failed
    ///     - `DecodingError`: If the response decoding failed
    public func unsubscribe(event: EventType, id: String? = nil) throws -> ResponseUnsubscribe {
        let nonce = generateNonce()
        let request = try RequestUnsubscribe(evt: event, nonce: nonce, id: id)
        let requestJSON = try request.jsonString()

        let response = try syncResponse(requestJSON: requestJSON, nonce: nonce)
        return try ResponseUnsubscribe.from(data: response)
    }

    /// Unsubscribe from an RPC event asynchronously.
    /// - Parameters:
    ///     - event: Event name to subscribe to
    ///     - id:
    ///         - A channel ID is required for this event types: `EventType.voiceStateCreate`, `EventType.voiceStateUpdate`,
    ///         `EventType.voiceStateDelete`, `EventType.messageCreate`, `EventType.messageUpdate`,
    ///         `EventType.messageDelete`, `EventType.speakingStart`, `EventType.speakingStop`
    ///         - A guild ID is required for this event type: `EventType.guildStatus`
    /// - Returns: A nonce `String` used to determine which response / error received on
    /// `DiscordRPC.onResponse(handler:)` / `DiscordRPC.onError(handler:)` correspond to a call to this command
    /// - Throws:
    ///     - `CommandError.invalidParameters(reason:)`: If the ID is not passed according to the event type
    ///     - `RPCError.writeFailed(error:)`: If the write operation on the socket failed     
    ///     - `EncodingError`: If the request encoding failed
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
        let request = RequestHandshake(clientID: self.clientID)
        let requestJSON = try request.jsonString()

        try self.send(requestJSON, .handshake)
        self.receive()
    }

    private func syncResponse(requestJSON: String, nonce: String, disableTimeout: Bool = false) throws -> Data {
        let semaphore = DispatchSemaphore(value: 0)
        var notification: Notification?
        var response: Data
        var error: EventError.EventErrorData?

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
