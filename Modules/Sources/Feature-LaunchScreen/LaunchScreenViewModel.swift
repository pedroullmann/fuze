import Core_DesignSystem
import Core_Resources
import Foundation
import SwiftUI

public final class LaunchScreenViewModel: ObservableObject {
    @Published private(set) var state: LaunchScreenState
    let environment: LaunchScreenEnvironment

    public init(
        initialState: LaunchScreenState = .init(),
        environment: LaunchScreenEnvironment
    ) {
        self.state = initialState
        self.environment = environment
        registerFonts()
        showHome()
    }

    private func registerFonts() {
        environment
            .resourcesBuilder()
            .registerFonts(
                fonts: Font.MontserratStyle.allCases,
                failureHandler: { debugPrint($0) }
            )
    }

    private func showHome() {
        environment.dispatchQueue
            .asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.state.route = .home
            }
    }
}
