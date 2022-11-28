import Feature_LaunchScreen
import Feature_Home_Repository_Live
import Feature_MatchDetails_Repository_Live
import SwiftUI

@main
struct FuzeApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchScreenView(
                viewModel: .init(
                    environment: .init(
                        homeService: .live,
                        matchDetailsService: .live
                    )
                )
            )
                .environment(\.locale, .init(identifier: "pt-BR"))
                .environment(\.colorScheme, .dark)
        }
    }
}
