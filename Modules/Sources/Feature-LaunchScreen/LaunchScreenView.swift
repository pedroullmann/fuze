import Core_DesignSystem
import Core_UI
import Core_Resources
import Feature_Home
import Root_Elements
import SwiftUI

public struct LaunchScreenView: View {
    @ObservedObject private var viewModel: LaunchScreenViewModel

    public init(viewModel: LaunchScreenViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        switch viewModel.state.route {
        case .splash:
            FullScreenColor(.backgroundPrimary) {
                Image(Asset.Media.logo)
            }

        case .home:
            NavigationView {
                FullScreenColor(.backgroundPrimary) {
                    HomeView(
                        viewModel: .init(
                            environment: .init(
                                service: viewModel.environment.homeService,
                                matchDetailsService: viewModel.environment.matchDetailsService
                            )
                        )
                    )
                }
            }
            .navigationViewStyle(.stack)
            .accentColor(.textPrimary)
        }
    }
}
