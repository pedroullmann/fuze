import Core_Resources
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
    }

    func registerFonts() {
        environment
            .resourcesBuilder()
            .registerFonts(
                fonts: Font.MontserratStyle.allCases,
                failureHandler: { debugPrint($0) } // TODO: Logger?
            )
    }
}
