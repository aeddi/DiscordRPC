import Foundation

/// [Buttons](https://discord.com/developers/docs/interactions/message-components#buttons)
/// [Select Menus](https://discord.com/developers/docs/interactions/message-components#select-menus)
/// [Action Rows](https://discord.com/developers/docs/interactions/message-components#action-rows)
/// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/interactions/message-components#component-object-component-structure)
public class Component: Codable {
    /// Component type; Valid for: all types
    public let type: ComponentType
    /// A developer-defined identifier for the component, max 100 characters; Valid for: Buttons, Select Menus
    public let customID: String?
    /// Whether the component is disabled, default false; Valid for: Buttons, Select Menus
    public let disabled: Bool?
    /// One of button styles; Valid for: Buttons
    public let style: Int?
    /// Text that appears on the button, max 80 characters; Valid for: Buttons
    public let label: String?
    /// `name`, `id`, and `animated`; Valid for: Buttons
    public let emoji: Emoji?
    /// A url for link-style buttons; Valid for: Buttons
    public let url: String?
    /// The choices in the select, max 25; Valid for: Select Menus
    public let options: [SelectOption]
    /// Custom placeholder text if nothing is selected, max 100 characters; Valid for: Select Menus
    public let placeholder: String?
    /// The minimum number of items that must be chosen; default 1, min 0, max 25; Valid for: Select Menus
    public let minValues: Int?
    /// The maximum number of items that can be chosen; default 1, max 25; Valid for: Select Menus
    public let maxValues: Int?
    /// A list of child components; Valid for: Action Rows
    public let components: [Component]?

    private enum CodingKeys: String, CodingKey {
        case type
        case customID  = "custom_id"
        case disabled
        case style
        case label
        case emoji
        case url
        case options
        case placeholder
        case minValues = "min_values"
        case maxValues = "max_values"
        case components
    }

    /// - SeeAlso: [Discord Reference](https://discord.com/developers/docs/interactions/message-components#select-menu-object-select-option-structure)
    public class SelectOption: Codable {
        /// The user-facing name of the option, max 25 characters
        public let label: String
        /// The dev-define value of the option, max 100 characters
        public let value: String
        /// An additional description of the option, max 50 characters
        public let description: String?
        /// `name`, `id`, and `animated`
        public let emoji: Emoji?
        /// Will render this option as selected by default
        public let defaultS: Bool?

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case label
            case value
            case description
            case emoji
            case defaultS = "default"
        }
    }
}
