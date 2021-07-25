import Foundation

/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/teams#data-models-team-object)
public class Team: Codable {
    /// A hash of the image of the team's icon
    public let icon: String?
    /// The unique ID of the team
    public let id: String
    /// The members of the team
    public let members: [TeamMember]
    /// The name of the team
    public let name: String
    /// The user ID of the current team owner
    public let ownerUserID: String

    private enum CodingKeys: String, CodingKey {
        case icon
        case id
        case members
        case name
        case ownerUserID = "owner_user_id"
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/topics/teams#data-models-team-members-object)
    public class TeamMember: Codable {
        /// The user's [membership state](https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum) on the team
        public let membershipState: MembershipState
        /// Will always be ["*"]
        public let permissions: [String]
        /// The ID of the parent team of which they are a member
        public let teamID: String
        /// The avatar, discriminator, ID, and username of the user
        public let user: User

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case membershipState = "membership_state"
            case permissions
            case teamID          = "team_id"
            case user
        }
    }
}
