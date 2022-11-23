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
        VStack(spacing: .zero) {
            Text("None")
                .foregroundColor(.textPrimary)

            Text("Heading")
                .textToken(.init(.heading1, .textPrimary))

            Text("Paragraph")
                .textToken(.init(.paragraph1, .textPrimary))

            Text("ParagraphBold")
                .textToken(.init(.paragraph1Bold, .textPrimary))

            Image(Asset.Media.logo)

        }
        .background(.backgroundPrimary)
    }
}
