import Combine

public final class MatchDetailsViewModel: ObservableObject {
    @Published private(set) var state: MatchDetailsState
    private let environment: MatchDetailsEnvironment
    public var cancellables: Set<AnyCancellable> = []

    public init(
        initialState: MatchDetailsState = .init(),
        environment: MatchDetailsEnvironment
    ) {
        self.state = initialState
        self.environment = environment
    }
}
