import UIKit

public struct LoginButtonModel {
    public let id: String
    public let title: String
    public let iconName: String?
    public let action: (() -> Void)?

    public init(id: String,
                title: String,
                iconName: String? = nil,
                action: (() -> Void)? = nil) {
        self.id = id
        self.title = title
        self.iconName = iconName
        self.action = action
    }
}
