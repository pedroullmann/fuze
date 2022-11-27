import Feature_LaunchScreen
import Feature_Home_Repository_Live
import SwiftUI

// TODO: Dependency Injection System? (ServiceLocator)
@main
struct FuzeApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchScreenView(
                viewModel: .init(
                    environment: .init(
                        homeService: .live
                    )
                )
            )
                .environment(\.locale, .init(identifier: "pt-BR"))
                .environment(\.colorScheme, .dark)
        }
    }
}
