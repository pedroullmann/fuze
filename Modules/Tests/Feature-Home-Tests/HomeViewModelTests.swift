import Combine
import Core_Networking_Interface
@testable import Feature_Home
import Feature_Home_Repository
import Root_Elements
import XCTest

final class HomeViewModelTests: XCTestCase {
    private let failWhenCalled: HomeService = .fixture(
        fetchRunningMatchs: {
            XCTFail("Should not call API")
            return Empty().eraseToAnyPublisher()
        },
        fetchUpcomingMatchs: { _, _ in
            XCTFail("Should not call API")
            return Empty().eraseToAnyPublisher()
        }
    )

    func test_fetch_whenServiceFails_shouldSetDataStateToError() {
        // Given
        let expectedDataState: DataState<[MatchModel]> = .error
        let sut = makeSut(
            initialState: .init(dataState: .loading),
            environment: .fixture(service: .failing)
        )
        // When
        sut.fetch()
        // Then
        XCTAssertEqual(sut.state.dataState, expectedDataState)
    }

    func test_fetch_whenServiceIsSuccessful_shouldSetDataStateToLoaded() {
        // Given
        let firstResponse: MatchModel = .fixture(id: 1)
        let secondResponse: MatchModel = .fixture(id: 2)
        let loaded = [firstResponse, secondResponse]
        let expectedDataState: DataState<[MatchModel]> = .loaded(loaded)
        let sut = makeSut(
            initialState: .init(
                dataState: .loading,
                pagination: .init(total: 0)
            ),
            environment: .fixture(
                service: .fixture(
                    fetchRunningMatchs: {
                        Just([firstResponse])
                            .setFailureType(to: HTTPRequestError.self)
                            .eraseToAnyPublisher()
                    },
                    fetchUpcomingMatchs: { _, _ in
                        Just([secondResponse])
                            .setFailureType(to: HTTPRequestError.self)
                            .eraseToAnyPublisher()
                    }
                )
            )
        )
        // When
        sut.fetch()
        // Then
        XCTAssertEqual(sut.state.dataState, expectedDataState)
        XCTAssertEqual(sut.state.pagination.total, loaded.count)
    }

    func test_loadMore_whenIsLoadingMoreMatchs_shouldNotCallAPI() {
        // Given
        let pagination: HomeViewModelState.Pagination = .init(page: 1)
        let sut = makeSut(
            initialState: .init(
                pagination: pagination,
                isLoadingMore: true
            ),
            environment: .fixture(service: failWhenCalled)
        )
        // When
        sut.loadMore(0)
        // Then
        XCTAssertEqual(sut.state.pagination.page, 1)
    }

    func test_loadMore_whenLimitIsTrue_shouldNotCallAPI() {
        // Given
        let pagination: HomeViewModelState.Pagination = .init(page: 1, limit: true)
        let sut = makeSut(
            initialState: .init(pagination: pagination),
            environment: .fixture(service: failWhenCalled)
        )
        // When
        sut.loadMore(0)
        // Then
        XCTAssertEqual(sut.state.pagination.page, 1)
    }

    func test_loadMore_whenOffsetIsNotEqualToPaginationTotal_shouldNotCallAPI() {
        // Given
        let offset = 25
        let pagination: HomeViewModelState.Pagination = .init(page: 1, total: 35)
        let sut = makeSut(
            initialState: .init(pagination: pagination),
            environment: .fixture(service: failWhenCalled)
        )
        // When
        sut.loadMore(offset)
        // Then
        XCTAssertEqual(sut.state.pagination.page, 1)
    }

    func test_loadMore_whenIsPossibleFetchMoreMatchs_andServiceFails_shouldNotAddMatchs() {
        // Given
        let offset = 24
        let pagination: HomeViewModelState.Pagination = .init(page: 1, total: 25)
        let sut = makeSut(
            initialState: .init(pagination: pagination),
            environment: .fixture(service: .failing)
        )
        // When
        sut.loadMore(offset)
        // Then
        XCTAssertEqual(sut.state.pagination.page, 1)
    }

    func test_loadMore_whenIsPossibleFetchMoreMatchs_andServiceIsSuccessful_andResponseIsNotEmpty_shouldAddMatchs() {
        // Given
        let offset = 24
        let pagination: HomeViewModelState.Pagination = .init(page: 1, total: 25)
        let expectedDataState: DataState<[MatchModel]> = .loaded([.fixture(id: 1), .fixture(id: 2)])
        let expectedTotalMatchs = 26
        let sut = makeSut(
            initialState: .init(
                dataState: .loaded([.fixture(id: 1)]),
                pagination: pagination
            ),
            environment: .fixture(
                service: .fixture(
                    fetchRunningMatchs: {
                        XCTFail("Should not call running matchs endpoint")
                        return Empty().eraseToAnyPublisher()
                    },
                    fetchUpcomingMatchs: { _, _ in
                        Just([.fixture(id: 2)])
                            .setFailureType(to: HTTPRequestError.self)
                            .eraseToAnyPublisher()
                    }
                )
            )
        )
        // When
        sut.loadMore(offset)
        // Then
        XCTAssertEqual(sut.state.pagination.total, expectedTotalMatchs)
        XCTAssertEqual(sut.state.pagination.page, 2)
        XCTAssertEqual(sut.state.dataState, expectedDataState)
    }

    func test_loadMore_whenIsPossibleFetchMoreMatchs_andServiceIsSuccessful_andResponseIsEmpty_shouldSetPaginationLimitToTrue() {
        let offset = 24
        let pagination: HomeViewModelState.Pagination = .init(page: 1, limit: false, total: 25)
        let sut = makeSut(
            initialState: .init(pagination: pagination),
            environment: .fixture(
                service: .fixture(
                    fetchRunningMatchs: {
                        XCTFail("Should not call running matchs endpoint")
                        return Empty().eraseToAnyPublisher()
                    },
                    fetchUpcomingMatchs: { _, _ in
                        Just([])
                            .setFailureType(to: HTTPRequestError.self)
                            .eraseToAnyPublisher()
                    }
                )
            )
        )
        // When
        sut.loadMore(offset)
        // Then
        XCTAssert(sut.state.pagination.limit)
        XCTAssertEqual(sut.state.pagination.page, 2)
    }
}

private extension HomeViewModelTests {
    func makeSut(
        initialState: HomeViewModelState = .init(),
        environment: HomeViewModelEnvironment = .fixture()
    ) -> HomeViewModel {
        .init(
            initialState: initialState,
            environment: environment
        )
    }
}
