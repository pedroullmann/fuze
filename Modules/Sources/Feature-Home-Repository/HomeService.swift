import Combine
import Core_Networking_Interface

public struct HomeService {
    private let fetchMatchs: (
        _ page: Int,
        _ size: Int
    ) -> AnyPublisher<[MatchModel], HTTPRequestError>

    public init(
        fetchMatchs: @escaping (
            _ page: Int,
            _ size: Int
        ) -> AnyPublisher<[MatchModel], HTTPRequestError>
    ) {
        self.fetchMatchs = fetchMatchs
    }
}

#if DEBUG
public extension HomeService {
    static let failing: Self = .fixture(
        fetchMatchs: { _, _ in
            Fail(error: HTTPRequestError.networking)
                .eraseToAnyPublisher()
        }
    )

    static let successful: Self = .fixture(
        fetchMatchs: { _, _ in
            Just(MatchModel.elements(5))
                .setFailureType(to: HTTPRequestError.self)
                .eraseToAnyPublisher()
        }
    )

    static func fixture(
        fetchMatchs: @escaping (
            _ page: Int,
            _ size: Int
        ) -> AnyPublisher<[MatchModel], HTTPRequestError>
    ) -> Self {
        .init(fetchMatchs: fetchMatchs)
    }
}
#endif
