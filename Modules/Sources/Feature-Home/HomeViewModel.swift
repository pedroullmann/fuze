import Combine
import Feature_Home_Repository
import SwiftUI

public final class HomeViewModel: ObservableObject {
    @Published private(set) var state: HomeViewModelState
    private let environment: HomeViewModelEnvironment

    public init(
        initialState: HomeViewModelState = .init(),
        environment: HomeViewModelEnvironment
    ) {
        self.state = initialState
        self.environment = environment
    }

    func fetch() {
        // TODO: Service
        let elements = MatchModel.elements(15)
        state.dataState = .loaded(elements)
    }

    func refresh() {
        state.pagination = .initial
        fetch()
    }

    func loadMore(_ offset: Int) {
        guard state.isLoadingMore == false else { return }
        guard state.pagination.limit == false else { return }
        guard offset == state.pagination.total else { return }

        state.isLoadingMore = true
        state.pagination.page += 1
        // TODO: Service
        // TODO: Validate when API return empty array
    }
}
