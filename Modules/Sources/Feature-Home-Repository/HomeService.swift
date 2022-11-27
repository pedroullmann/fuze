import Combine
import Core_Networking_Interface

public struct HomeService {
    public let fetchRunningMatchs: () -> AnyPublisher<[MatchModel], HTTPRequestError>
    public let fetchUpcomingMatchs: (_ page: Int, _ size: Int) -> AnyPublisher<[MatchModel], HTTPRequestError>

    public init(
        fetchRunningMatchs: @escaping () -> AnyPublisher<[MatchModel], HTTPRequestError>,
        fetchUpcomingMatchs: @escaping (_ page: Int, _ size: Int) -> AnyPublisher<[MatchModel], HTTPRequestError>
    ) {
        self.fetchRunningMatchs = fetchRunningMatchs
        self.fetchUpcomingMatchs = fetchUpcomingMatchs
    }
}

#if DEBUG
public extension HomeService {
    static let failing: Self = .fixture(
        fetchRunningMatchs: {
            Fail(error: HTTPRequestError.networking)
                .eraseToAnyPublisher()
        },
        fetchUpcomingMatchs: { _, _ in
            Fail(error: HTTPRequestError.networking)
                .eraseToAnyPublisher()
        }
    )

    static func fixture(
        fetchRunningMatchs: @escaping () -> AnyPublisher<[MatchModel], HTTPRequestError>,
        fetchUpcomingMatchs: @escaping (_ page: Int, _ size: Int) -> AnyPublisher<[MatchModel], HTTPRequestError>
    ) -> Self {
        .init(
            fetchRunningMatchs: fetchRunningMatchs,
            fetchUpcomingMatchs: fetchUpcomingMatchs
        )
    }
}
#endif
