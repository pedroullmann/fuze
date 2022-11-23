import Core_Resources
@testable import Feature_LaunchScreen
import Root_Elements
import XCTest

final class LaunchScreenViewModelTests: XCTestCase {
    func test_viewModelInitializer_shouldCallResourcesToRegisterFonts() {
        // Given // When
        let resources = ResourcesSpy(registerFontsWasCalled: false)
        let _ = makeSut(environment: .fixture(resourcesBuilder: { resources }))
        // Then
        XCTAssert(resources.registerFontsWasCalled)
    }

    func test_viewModelInitializer_shouldShowHome() {
        // Given
        let sut: LaunchScreenViewModel
        let immediate = DispatchQueueImmediate()
        // When
        sut = makeSut(
            initialState: .init(initialRoute: .splash),
            environment: .fixture(dispatchQueue: immediate)
        )
        // Then
        XCTAssertEqual(sut.state.route, .home)
    }
}

private extension LaunchScreenViewModelTests {
    func makeSut(
        initialState: LaunchScreenState = .init(),
        environment: LaunchScreenEnvironment = .fixture()
    ) -> LaunchScreenViewModel {
        .init(
            initialState: initialState,
            environment: environment
        )
    }
}
