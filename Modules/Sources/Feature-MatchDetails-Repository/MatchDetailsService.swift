import Combine
import Core_Networking_Interface

public struct MatchDetailsService {
    public let fetchPlayers: (
        _ teamId: Int
    ) -> AnyPublisher<[PlayerModel], HTTPRequestError>

    public init(
        fetchPlayers: @escaping (
            _ teamId: Int
        ) -> AnyPublisher<[PlayerModel], HTTPRequestError>
    ) {
        self.fetchPlayers = fetchPlayers
    }
}

#if DEBUG
public extension MatchDetailsService {
    static let failing: Self = .fixture(
        fetchPlayers: { _ in
            Fail(error: HTTPRequestError.networking)
                .eraseToAnyPublisher()
        }
    )

    static func fixture(
        fetchPlayers: @escaping (
            _ teamId: Int
        ) -> AnyPublisher<[PlayerModel], HTTPRequestError>
    ) -> Self {
        .init(fetchPlayers: fetchPlayers)
    }
}
#endif
