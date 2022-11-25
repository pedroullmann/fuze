import Combine
import SwiftUI

public final class HomeViewModel: ObservableObject {
    @Published private(set) var state: HomeViewModelState
    private let environment: HomeViewModelEnvironment

    public init(
        initialState: HomeViewModelState = .init(),
        environment: HomeViewModelEnvironment = .init()
    ) {
        self.state = initialState
        self.environment = environment
    }

    func fetch() {
        // TODO: Service
        let elements = MatchModel.elements(15)
        state.dataState = .loaded(elements)
    }
}
