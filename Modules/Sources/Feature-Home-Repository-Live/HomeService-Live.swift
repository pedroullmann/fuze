import Combine
import Core_Networking
import Core_Networking_Interface
import Feature_Home_Repository

public extension HomeService {
    static let live: Self = .init(
        fetchRunningMatchs: {
            let dispatcher = HTTPRequestDispatcher()
            let endpoint: HomeHTTPEndpoint = .fetchRunningMatchs
            let publisher: AnyPublisher<[MatchResponse], HTTPRequestError> = dispatcher
                .dataPublisher(for: endpoint)

            return publisher
                .map { $0.compactMap(MatchModel.init) }
                .map { $0.filter { $0.opponents.count > 1 }}
                .eraseToAnyPublisher()
        },
        fetchUpcomingMatchs: { page, size in
            let dispatcher = HTTPRequestDispatcher()
            let endpoint: HomeHTTPEndpoint = .fetchUpcomingMatchs(page: page, size: size)
            let publisher: AnyPublisher<[MatchResponse], HTTPRequestError> = dispatcher
                .dataPublisher(for: endpoint)

            return publisher
                .map { $0.compactMap(MatchModel.init) }
                .map { $0.filter { $0.opponents.count > 1 }}
                .eraseToAnyPublisher()
        }
    )
}

private extension MatchModel {
    init(_ response: MatchResponse) {
        self = .init(
            id: response.id,
            scheduledAt: response.scheduledAt,
            opponents: response.opponents.map {
                MatchModel.Opponent.init($0.opponent)
            },
            league: .init(
                name: response.league.name,
                imageUrl: response.league.imageUrl
            ),
            serie: response.serie.fullName,
            status: MatchModel.Status.init(response.status)
        )
    }
}

public extension MatchModel.Opponent {
    init(_ response: MatchResponse.OpponentObject.Opponent) {
        self = .init(
            id: response.id,
            imageUrl: response.imageUrl,
            name: response.name
        )
    }
}

public extension MatchModel.Status {
    init(_ response: MatchResponse.Status) {
        switch response {
        case .finished:
            self = .finished
        case .notPlayed:
            self = .notPlayed
        case .notStarted:
            self = .notStarted
        case .running:
            self = .running
        case .canceled:
            self = .canceled
        case .postponed:
            self = .postponed
        }
    }
}
