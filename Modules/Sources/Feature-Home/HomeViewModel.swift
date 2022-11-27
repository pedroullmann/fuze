import Combine
import Feature_Home_Repository
import SwiftUI

public final class HomeViewModel: ObservableObject {
    @Published private(set) var state: HomeViewModelState
    private let environment: HomeViewModelEnvironment
    private var cancellables: Set<AnyCancellable> = []

    public init(
        initialState: HomeViewModelState = .init(),
        environment: HomeViewModelEnvironment
    ) {
        self.state = initialState
        self.environment = environment
    }

    func fetch() {
        state.dataState = .loading
        let page = state.pagination.page
        let size = state.pagination.size
        let runningMatchs = environment.service.fetchRunningMatchs()
        let upcomingMatchs = environment.service.fetchUpcomingMatchs(page, size)

        Publishers.Zip(runningMatchs, upcomingMatchs)
            .receive(on: environment.scheduler)
            .sink(
                receiveCompletion: { [self] response in
                    if case .failure = response { state.dataState = .error }
                },
                receiveValue: { [self] (running, upcoming) in
                    var matchs = running
                    matchs.append(contentsOf: upcoming)
                    state.pagination.total = matchs.count
                    state.dataState = .loaded(matchs)
                }
            )
            .store(in: &cancellables)
    }

    func loadMore(_ offset: Int) {
        guard state.isLoadingMore == false else { return }
        guard state.pagination.limit == false else { return }
        guard offset == (state.pagination.total - 1) else { return }

        state.isLoadingMore = true
        let page = state.pagination.page
        let size = state.pagination.size

        environment.service.fetchUpcomingMatchs(page, size)
            .receive(on: environment.scheduler)
            .sink(
                receiveCompletion: { [self] _ in
                    state.isLoadingMore = false
                },
                receiveValue: { [self] upcoming in
                    state.pagination.page += 1
                    guard upcoming.isEmpty == false else {
                        state.pagination.limit = true
                        return
                    }

                    if var matchs = state.dataState.model {
                        matchs.append(contentsOf: upcoming)
                        state.pagination.total += upcoming.count
                        state.dataState = .loaded(matchs)
                    }
                }
            )
            .store(in: &cancellables)
    }
}
