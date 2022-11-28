import Combine
import Core_Networking_Interface
@testable import Feature_MatchDetails
import Feature_MatchDetails_Repository
import Feature_Home_Repository
import Root_Elements
import XCTest

final class MatchDetailsViewModelTests: XCTestCase {
    func test_fetch_whenServiceFails_shouldSetDataStateToError() {
        // Given
        let expectedDataState: DataState<MatchDetailsState.Players> = .error
        let sut = makeSut(
            initialState: .init(dataState: .loading),
            environment: .fixture(service: .failing)
        )
        // When
        sut.fetch(.fixture(opponents: MatchModel.Opponent.elements))
        // Then
        XCTAssertEqual(sut.state.dataState, expectedDataState)
    }

    func test_fetch_whenIsSuccessful_shouldSetDataStateToLoaded() {
        // Given
        let players: MatchDetailsState.Players = .init(team: [], rival: [])
        let expectedDataState: DataState<MatchDetailsState.Players> = .loaded(players)
        let sut = makeSut(
            initialState: .init(dataState: .loading),
            environment: .fixture(
                service: .fixture(
                    fetchPlayers: { _ in
                        Just([])
                            .setFailureType(to: HTTPRequestError.self)
                            .eraseToAnyPublisher()
                    }
                )
            )
        )
        // When
        sut.fetch(.fixture(opponents: MatchModel.Opponent.elements))
        // Then
        XCTAssertEqual(sut.state.dataState, expectedDataState)
    }
}

private extension MatchDetailsViewModelTests {
    func makeSut(
        initialState: MatchDetailsState = .init(),
        environment: MatchDetailsEnvironment = .fixture()
    ) -> MatchDetailsViewModel {
        .init(
            initialState: initialState,
            environment: environment
        )
    }
}
