import Combine
import Feature_Home_Repository
import Root_Elements
import SwiftUI

public final class HomeViewModel: ObservableObject, LoadableOnFirstAppearance {
    @Published private(set) var state: HomeViewModelState
    let environment: HomeViewModelEnvironment
    public let onAppear: PassthroughSubject<Void, Never> = .init()
    public var cancellables: Set<AnyCancellable> = []

    public init(
        initialState: HomeViewModelState = .init(),
        environment: HomeViewModelEnvironment
    ) {
        self.state = initialState
        self.environment = environment
        loadingOnFirstAppearance()
    }

    public func fetch() {
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
        state.pagination.page += 1
        let page = state.pagination.page
        let size = state.pagination.size

        environment.service.fetchUpcomingMatchs(page, size)
            .receive(on: environment.scheduler)
            .sink(
                receiveCompletion: { [self] _ in
                    state.isLoadingMore = false
                },
                receiveValue: { [self] upcoming in
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

    func navigateToDetail(_ match: MatchModel) {
        state.selectedMatch = match
    }
}

public extension HomeViewModel {
    var isNavigationActive: Binding<Bool> {
        .init(
            get: { [self] in state.selectedMatch != nil },
            set: { [self] isActive in
                if isActive == false  {
                    state.selectedMatch = nil
                }
            }
        )
    }
}
