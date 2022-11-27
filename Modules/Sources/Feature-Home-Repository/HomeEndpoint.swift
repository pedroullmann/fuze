import Combine
import Core_Networking_Interface

public enum HomeHTTPEndpoint {
    case fetchRunningMatchs
    case fetchUpcomingMatchs(page: Int, size: Int)
}

extension HomeHTTPEndpoint: HTTPRequestProtocol {
    public var path: String {
        switch self {
        case .fetchRunningMatchs:
            return "/csgo/matches/running"
        case .fetchUpcomingMatchs:
            return "/csgo/matches/upcoming"
        }
    }

    public var parameters: HTTPRequestParameters {
        switch self {
        case .fetchRunningMatchs:
            return .urlQuery(
                [
                    "page[number]": "1",
                    "page[size]": "50"
                ]
            )
        case let .fetchUpcomingMatchs(page, size):
            return .urlQuery(
                [
                    "sort": "scheduled_at",
                    "page[number]": "\(page)",
                    "page[size]": "\(size)"
                ]
            )
        }
    }
}
