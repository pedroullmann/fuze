import Combine
import Feature_Home_Repository

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

    func fetch(_ match: MatchModel) {
        guard let team = match.opponents.first else { return }
        guard let rival = match.opponents.last else { return }

        state.dataState = .loading
        let teamPublisher = environment.service.fetchPlayers(team.id)
        let rivalPublisher = environment.service.fetchPlayers(rival.id)

        Publishers.Zip(teamPublisher, rivalPublisher)
            .receive(on: environment.scheduler)
            .sink(
                receiveCompletion: { [self] response in
                    if case .failure = response { state.dataState = .error }
                },
                receiveValue: { [self] (team, rival) in
                    let players: MatchDetailsState.Players = .init(team: team, rival: rival)
                    state.dataState = .loaded(players)
                }
            )
            .store(in: &cancellables)
    }
}
