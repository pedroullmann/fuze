import Foundation

public struct PlayerModel: Equatable, Identifiable {
    public var id: Int
    public let nickname: String
    public let firstName: String?
    public let lastName: String?
    public let imageUrl: String?

    public init(
        id: Int,
        nickname: String,
        firstName: String?,
        lastName: String?,
        imageUrl: String?
    ) {
        self.id = id
        self.nickname = nickname
        self.firstName = firstName
        self.lastName = lastName
        self.imageUrl = imageUrl
    }
}
