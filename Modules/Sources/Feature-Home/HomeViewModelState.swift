import Feature_Home_Repository
import Foundation
import Root_Elements

public struct HomeViewModelState: Equatable {
    var dataState: DataState<[MatchModel]>
    var pagination: Pagination
    var isLoadingMore: Bool

    public init(
        dataState: DataState<[MatchModel]> = .loading,
        pagination: Pagination = .init(),
        isLoadingMore: Bool = false
    ) {
        self.dataState = dataState
        self.pagination = pagination
        self.isLoadingMore = isLoadingMore
    }
}

public extension HomeViewModelState {
    struct Pagination: Equatable {
        public var page: Int
        public var limit: Bool
        public var total: Int
        public let size: Int

        public init(
            page: Int = 1,
            limit: Bool = false,
            size: Int = 25,
            total: Int = 0
        ) {
            self.page = page
            self.limit = limit
            self.size = size
            self.total = total
        }
    }
}

public extension HomeViewModelState.Pagination {
    static let initial: Self = .init()
}
