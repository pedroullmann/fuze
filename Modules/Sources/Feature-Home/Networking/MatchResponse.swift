import Foundation

public struct MatchResponse: Decodable {
    public let id: String
    public let beginAt: String?
    public let opponents: [Opponent]
    public let league: League
    public let serie: Serie
    public let status: Status

    public enum CodingKeys: String, CodingKey {
        case id
        case beginAt = "begin_at"
        case opponents
        case league
        case serie
        case status
    }

    public struct Opponent: Decodable {
        public let id: String
        public let imageUrl: String?
        public let name: String

        public enum CodingKeys: String, CodingKey {
            case id
            case imageUrl = "image_url"
            case name
        }
    }

    public struct League: Decodable {
        public let name: String
        public let imageUrl: String?

        public enum CodingKeys: String, CodingKey {
            case name
            case imageUrl = "image_url"
        }
    }

    public struct Serie: Decodable {
        public let fullName: String

        public enum CodingKeys: String, CodingKey {
            case fullName = "full_name"
        }
    }

    public enum Status: String, Decodable {
        case finished
        case notPlayed = "not_played"
        case notStarted = "not_started"
        case running
    }
}
