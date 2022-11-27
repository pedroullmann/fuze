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
        environment
            .service
            .fetchMatchs(
                state.pagination.page,
                state.pagination.size
            )
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [self] response in
                    if case .failure = response {
                        state.dataState = .error
                    }
                },
                receiveValue: { [self] data in
                    state.dataState = .loaded(data)
                }
            )
            .store(in: &cancellables)
    }

    func loadMore(_ offset: Int) {
        guard state.isLoadingMore == false else { return }
        guard state.pagination.limit == false else { return }
        guard offset == state.pagination.total else { return }
        state.isLoadingMore = true
        state.pagination.page += 1

        environment
            .service
            .fetchMatchs(
                state.pagination.page,
                state.pagination.size
            )
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [self] _ in
                    state.isLoadingMore = false
                },
                receiveValue: { [self] data in
                    if var current = state.dataState.model {
                        current.append(contentsOf: data)
                        state.dataState = .loaded(current)
                    }
                }
            )
            .store(in: &cancellables)
    }
}
