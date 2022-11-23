import Core_DesignSystem
import Core_UI
import Core_Resources
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
            .statusBarHidden()

        case .home:
            Text("Home")
        }
    }
}
