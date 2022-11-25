import Foundation
import Root_Elements

public struct HomeViewModelState: Equatable {
    var dataState: DataState<[MatchModel]>
    var pagination: Pagination

    public init(
        dataState: DataState<[MatchModel]> = .loading,
        pagination: Pagination = .init()
    ) {
        self.dataState = dataState
        self.pagination = pagination
    }
}

public extension HomeViewModelState {
    struct Pagination: Equatable {
        public init() {}
    }
}
