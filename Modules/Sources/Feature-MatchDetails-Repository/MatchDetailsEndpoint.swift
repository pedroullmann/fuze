import Combine
import Core_Networking_Interface

public enum MatchDetailsHTTPEndpoint {
    case fetchPlayers(teamId: Int)
}

extension MatchDetailsHTTPEndpoint: HTTPRequestProtocol {
    public var path: String {
        switch self {
        case .fetchPlayers:
            return "/csgo/players"
        }
    }

    public var parameters: HTTPRequestParameters {
        switch self {
        case let .fetchPlayers(teamId):
            return .urlQuery(
                [
                    "filter[team_id]": "\(teamId)"
                ]
            )
        }
    }
}
