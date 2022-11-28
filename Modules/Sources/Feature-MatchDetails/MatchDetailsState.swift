import Foundation
import Root_Elements
import Feature_MatchDetails_Repository

public struct MatchDetailsState: Equatable {
    var dataState: DataState<Players>

    public init(dataState: DataState<Players> = .loading) {
        self.dataState = dataState
    }
}

public extension MatchDetailsState {
    struct Players: Equatable {
        let team: [PlayerModel]
        let rival: [PlayerModel]
    }
}
