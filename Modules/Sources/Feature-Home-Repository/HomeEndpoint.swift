import Combine
import Core_Networking_Interface

public enum HomeHTTPEndpoint {
    case fetchMatchs(page: Int, size: Int)
}

extension HomeHTTPEndpoint: HTTPRequestProtocol {
    public var path: String {
        switch self {
        case .fetchMatchs:
            return "/csgo/matches"
        }
    }

    public var parameters: HTTPRequestParameters {
        switch self {
        case let .fetchMatchs(page, size):
            return .urlQuery(
                [
                    "page[number]": "\(page)",
                    "page[size]": "\(size)"
                ]
            )
        }
    }
}
