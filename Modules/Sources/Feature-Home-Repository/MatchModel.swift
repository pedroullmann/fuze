import Foundation

public struct MatchModel: Equatable, Identifiable {
    public var id: Int?
    public let scheduledAt: String?
    public let opponents: [Opponent]
    public let league: League
    public let serie: String
    public let status: Status

    public init(
        id: Int?,
        scheduledAt: String?,
        opponents: [Opponent],
        league: League,
        serie: String,
        status: Status
    ) {
        self.id = id
        self.scheduledAt = scheduledAt
        self.opponents = opponents
        self.league = league
        self.serie = serie
        self.status = status
    }

    public struct Opponent: Equatable, Identifiable {
        public var id: Int
        public let imageUrl: String?
        public let name: String

        public init(
            id: Int,
            imageUrl: String?,
            name: String
        ) {
            self.id = id
            self.imageUrl = imageUrl
            self.name = name
        }
    }

    public struct League: Equatable {
        public let name: String
        public let imageUrl: String?

        public init(
            name: String,
            imageUrl: String?
        ) {
            self.name = name
            self.imageUrl = imageUrl
        }
    }

    public enum Status: String, Equatable {
        case finished
        case notPlayed = "not_played"
        case notStarted = "not_started"
        case running
        case canceled
        case postponed

        public var isRunning: Bool {
            self == .running
        }
    }
}

#if DEBUG
public extension MatchModel {
    static func elements(_ quantity: Int) -> [Self] {
        (0...quantity).map { .fixture(id: $0, opponents: Opponent.elements) }
    }

    static func fixture(
        id: Int = 1,
        scheduledAt: String = "Date",
        opponents: [Opponent] = [],
        league: League = .init(name: "League", imageUrl: "Mock"),
        serie: String = "Serie",
        status: Status = .notStarted
    ) -> Self {
        .init(
            id: id,
            scheduledAt: scheduledAt,
            opponents: opponents,
            league: league,
            serie: serie,
            status: status
        )
    }
}

public extension MatchModel.Opponent {
    static let elements: [Self] = [
        .fixture(id: 1, name: "Opponent 1"),
        .fixture(id: 2, name: "Opponent 2")
    ]

    static func fixture(
        id: Int = 1,
        imageUrl: String = "Mock",
        name: String = "Opponent"
    ) -> Self {
        .init(
            id: id,
            imageUrl: imageUrl,
            name: name
        )
    }
}
#endif
