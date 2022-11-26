import Combine
import Core_Networking
import Core_Networking_Interface
import Feature_Home_Repository

public extension HomeService {
    static let live: Self = .init(
        fetchMatchs: { page, size in
            let dispatcher = HTTPRequestDispatcher()
            let endpoint: HomeHTTPEndpoint = .fetchMatchs(page: page, size: size)
            let publisher: AnyPublisher<[MatchResponse], HTTPRequestError> = dispatcher
                .dataPublisher(for: endpoint)

            return publisher
                .map { $0.compactMap(MatchModel.init) }
                .eraseToAnyPublisher()
        }
    )
}

private extension MatchModel {
    init(_ response: MatchResponse) {
        self = .init(
            id: response.id,
            beginAt: response.beginAt,
            opponents: response.opponents.map(MatchModel.Opponent.init),
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
    init(_ response: MatchResponse.Opponent) {
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
        }
    }
}
