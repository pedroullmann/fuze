import Core_DesignSystem
import Core_Resources
import Foundation
import SwiftUI

public final class LaunchScreenViewModel: ObservableObject {
    @Published private(set) var state: LaunchScreenState
    private let environment: LaunchScreenEnvironment

    public init(
        initialState: LaunchScreenState = .init(),
        environment: LaunchScreenEnvironment = .init()
    ) {
        self.state = initialState
        self.environment = environment
        registerFonts()
        navigateToHome()
    }

    private func registerFonts() {
        environment
            .resourcesBuilder()
            .registerFonts(
                fonts: Font.MontserratStyle.allCases,
                failureHandler: { debugPrint($0) } // TODO: Logger?
            )
    }

    private func navigateToHome() {
        environment.dispatchQueue
            .asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.state.route = .home
            }
    }
}
