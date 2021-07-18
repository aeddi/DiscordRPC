# DiscordRPC

[![Build](https://img.shields.io/github/workflow/status/aeddi/DiscordRPC/Release)](https://github.com/aeddi/DiscordRPC/actions/workflows/release.yml)
[![Release](https://img.shields.io/github/v/release/aeddi/DiscordRPC?color=success)](https://github.com/aeddi/DiscordRPC/releases)
[![Platform](https://img.shields.io/badge/platform-macOS%2011-orange)](#Requirements)
[![Language](https://img.shields.io/badge/language-Swift%205-orange)](#Requirements)
[![Documentation](https://img.shields.io/badge/documentation-Jazzy-blueviolet)](https://aeddi.github.io/DiscordRPC)
[![License](https://img.shields.io/github/license/aeddi/DiscordRPC?color=blue)](https://github.com/aeddi/DiscordRPC/blob/master/LICENSE)

A Discord RPC library for Swift on macOS.  

All commands and payloads are wrapped in Swift methods and types.  

**Note**: Works only with IPC for now because the Discord Websocket RPC API seems
to be disabled. See [this issue](https://github.com/discord/discord-rpc/issues/342).

## Requirements

- macOS >= 11 (Big Sur)
- Swift 5
- No [App Sandbox](https://developer.apple.com/documentation/security/app_sandbox)
as this library needs to access to Discord
[UDS](https://en.wikipedia.org/wiki/Unix_domain_socket) file

## Usage

### Installation

DiscordRPC library is available as a [Swift Package Manager](https://developer.apple.com/documentation/swift_packages)
package.  

You can use it as a dependency of your own package by adding this in its `Package.swift`:

```swift
dependencies: [
    .Package(url: "https://github.com/aeddi/DiscordRPC.git", from: "1.0.0")
]
```

Or you can add it to your XCode project by following [this tutorial](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).

### Code Example

You will first need to create an application on the [Discord Developer Dashboard](https://discord.com/developers/applications)
and then to retrieve the Client ID (and optionally the Client Secret depending
on your use case) in the OAuth2 section.

#### Complete demo

```swift
import DiscordRPC
import Dispatch

// Instantiate DiscordRPC using client ID and Secret
let discordRPC = DiscordRPC(clientID: "XXXXXX", clientSecret: "YYYYYY")

// This handler is called as soon as the Discord RPC handshake succeeded
discordRPC.onConnect { rpc, eventReady in
    print("Connection to Discord RPC API succeeded")

    do {
        // Ask user authorization by displaying a popup on the Discord client
        let authorization = try rpc.authorize(oAuth2Scopes: [.rpc])

        // Request an access token on Discord servers using the authorization code
        let accessToken = try rpc.fetchAccessToken(code: authorization.data.code)

        // Authenticate to Discord RPC API using the access token
        let authentication = try rpc.authenticate(accessToken: accessToken.accessToken)

        print("Hello \(authentication.data.user.username)! o/")

        // Receive an event when the local user select a voice channel
        _ = try rpc.subscribe(event: .voiceChannelSelect)
    } catch {
        rpc.disconnect()
        print("Error occured: \(error)")
        exit(42)
    }
}

// This handler is called when a disconnection with the Discord RPC socket occurs
discordRPC.onDisconnect { rpc, eventClose in
    print("Disconnection occurred: [\(eventClose.code)] \(eventClose.message)")
}

// This handler is called when a response to an async command is received
discordRPC.onResponse { rpc, nonce, commandType, response in
    print("Response received for command \(commandType) with nonce: \(nonce)")
}

// This handler is called when an error for an async command occurs
discordRPC.onError { rpc, nonce, eventError in
    print("Error occured on command \(eventError.cmd): [\(eventError.data.code)] \(eventError.data.message)")
}

// This handler is called when an update to a subscribed event is received
discordRPC.onEvent { rpc, eventType, event in
    print("Event received of type \(eventType))")

    // Cast raw event (Data) to SelectVoiceChannelEvent
    if eventType == .voiceChannelSelect {
        if let eventSVC = try? EventVoiceChannelSelect.from(data: event) {
            if let channelID = eventSVC.data.channelID {
                print("Voice channel \(channelID) selected!")
            } else {
                print("Voice channel deselected!")
            }
        }
    }
}

// Init connection
do {
    try discordRPC.connect()
    dispatchMain()
} catch {
    print("An error occured during connection init: \(error)")
}

```

#### Avatar image

You can fetch a user avatar on Discord servers using this helper:

```swift
let authentication = try rpc.authenticate(accessToken: accessToken.accessToken)
let user = authentication.data.user

let avatar: NSImage = try user.fetchAvatarImage()
```

Or this one:

```swift
let authentication = try rpc.authenticate(accessToken: accessToken.accessToken)
let user = authentication.data.user

let avatar: NSImage = try fetchUserAvatarImage(id: user.id, avatar: user.avatar)
```

#### Reusing access token

To avoid asking authorization to user on each run, you can persist the access
token (e.g. by using UserDefaults) and pass it directly to `authenticate(accessToken:)`.

```swift
func persistentAuthentication(rpc: DiscordRPC) throws -> ResponseAuthenticate {
    let defaults = UserDefaults.standard
    let now = Date()

    // If a previous token exists in UserDefaults and is still valid, use it
    if let tokenValidity = defaults.object(forKey: "tokenValidity") as? Date,
        tokenValidity > now {
        if let accessTokenData = defaults.data(forKey: "token") {
            do {
                let accessToken = try AccessToken.from(data: accessTokenData)
                return try rpc.authenticate(accessToken: accessToken.accessToken)
            } catch { /* ignore */ }
        }
    }

    // Else request a new token
    let authorization = try rpc.authorize(oAuth2Scopes: [.rpc])
    let accessToken = try rpc.fetchAccessToken(code: authorization.data.code)
    let authentication = try rpc.authenticate(accessToken: accessToken.accessToken)

    // Then save it in UserDefaults for the next call
    defaults.set(authentication.data.expires, forKey: "tokenValidity")
    defaults.set(try newJSONEncoder().encode(accessToken), forKey: "token")

    return authentication
}
```

### Documentation

Generated using [Jazzy](https://github.com/realm/jazzy) and hosted on [GitHub Pages](https://aeddi.github.io/DiscordRPC).

## Changelog

See [Changelog.md](https://github.com/aeddi/DiscordRPC/blob/master/CHANGELOG.md).

## Credits

Thanks to [@Azoy](https://github.com/Azoy) for his [SwordRPC](https://github.com/Azoy/SwordRPC)
repo from which I basically copied the IPC communication part.
