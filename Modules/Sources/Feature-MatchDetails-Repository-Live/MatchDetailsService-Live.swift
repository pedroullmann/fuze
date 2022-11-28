import Combine
import Core_Networking
import Core_Networking_Interface
import Feature_MatchDetails_Repository

public extension MatchDetailsService {
    static let live: Self = .init(
        fetchPlayers: { teamId in
            let dispatcher = HTTPRequestDispatcher()
            let endpoint: MatchDetailsHTTPEndpoint = .fetchPlayers(teamId: teamId)
            let publisher: AnyPublisher<[PlayerResponse], HTTPRequestError> = dispatcher
                .dataPublisher(for: endpoint)

            return publisher
                .map { $0.compactMap(PlayerModel.init) }
                .eraseToAnyPublisher()
        }
    )
}

private extension PlayerModel {
    init(_ response: PlayerResponse) {
        self = .init(
            id: response.id,
            nickname: response.nickname,
            firstName: response.firstName,
            lastName: response.lastName,
            imageUrl: response.imageUrl
        )
    }
}
