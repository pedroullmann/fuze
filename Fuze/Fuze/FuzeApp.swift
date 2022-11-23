import Feature_LaunchScreen
import SwiftUI

@main
struct FuzeApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchScreenView(viewModel: .init())
                .preferredColorScheme(.dark)
        }
    }
}
