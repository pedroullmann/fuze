import Core_DesignSystem
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
                .font(.system(size: 64))
                .foregroundColor(.textPrimary)
            Text("Regular")
                .font(.montserrat(.regular, fixedSize: 64))
                .foregroundColor(.textPrimary)
            Text("Bold")
                .font(.montserrat(.bold, fixedSize: 64))
                .foregroundColor(.textPrimary)
            Image(Asset.Media.logo)

        }
        .background(.backgroundPrimary)
    }
}
