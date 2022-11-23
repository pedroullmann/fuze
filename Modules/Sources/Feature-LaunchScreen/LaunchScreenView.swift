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
                .textToken(.init(typography: .heading1, color: .textPrimary))

            Text("Paragraph")
                .textToken(.init(typography: .paragraph1, color: .textPrimary))

            Text("ParagraphBold")
                .textToken(.init(typography: .paragraph1Bold, color: .textPrimary))

            Image(Asset.Media.logo)

        }
        .background(.backgroundPrimary)
    }
}
