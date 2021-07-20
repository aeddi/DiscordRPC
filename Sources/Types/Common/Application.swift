/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/resources/application#application-object-application-structure)
public class Application: Codable {
    /// The ID of the app
    public let id: String
    /// The name of the app
    public let name: String
    /// The [icon hash](https://discord.com/developers/docs/reference#image-formatting) of the app
    public let icon: String?
    /// The description of the app
    public let description: String
    /// An array of rpc origin urls, if rpc is enabled
    public let rpcOrigins: [String]?
    /// When false only app owner can join the app's bot to guilds
    public let botPublic: Bool
    /// When true the app's bot will only join upon completion of the full oauth2 code grant flow
    public let botRequireCodeGrant: Bool
    /// The url of the app's terms of service
    public let termsOfServiceURL: String?
    /// The url of the app's privacy policy
    public let privacyPolicyURL: String?
    /// Partial user object containing info on the owner of the application
    public let owner: User?
    /// If this application is a game sold on Discord, this field will be the summary field for the store page of its primary sku
    public let summary: String
    /// The hex encoded key for verification in interactions and the GameSDK's [GetTicket](https://discord.com/developers/docs/game-sdk/applications#getticket)
    public let verifyKey: String
    /// If the application belongs to a team, this will be a list of the members of that team
    public let team: Team?
    /// If this application is a game sold on Discord, this field will be the guild to which it has been linked
    public let guildID: String?
    /// If this application is a game sold on Discord, this field will be the ID of the "Game SKU" that is created, if exists
    public let primarySkuID: String?
    /// If this application is a game sold on Discord, this field will be the URL slug that links to the store page
    public let slug: String?
    /// The application's default rich presence invite [cover image hash](https://discord.com/developers/docs/reference#image-formatting)
    public let coverImage: String?
    /// The application's public [flags](https://discord.com/developers/docs/resources/application#application-application-flags)
    public let flags: Int?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case icon
        case description
        case rpcOrigins          = "rpc_origins"
        case botPublic           = "bot_public"
        case botRequireCodeGrant = "bot_require_code_grant"
        case termsOfServiceURL   = "terms_of_service_url"
        case privacyPolicyURL    = "privacy_policy_url"
        case owner
        case summary
        case verifyKey           = "verify_key"
        case team
        case guildID             = "guild_id"
        case primarySkuID        = "primary_sku_id"
        case slug
        case coverImage          = "cover_image"
        case flags
    }
}
