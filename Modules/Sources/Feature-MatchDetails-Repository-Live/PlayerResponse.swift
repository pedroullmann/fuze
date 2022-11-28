import Foundation

public struct PlayerResponse: Decodable {
    public var id: Int
    public let nickname: String
    public let firstName: String?
    public let lastName: String?
    public let imageUrl: String?

    public enum CodingKeys: String, CodingKey {
        case id
        case nickname = "name"
        case firstName = "first_name"
        case lastName = "last_name"
        case imageUrl = "image_url"
    }
}
