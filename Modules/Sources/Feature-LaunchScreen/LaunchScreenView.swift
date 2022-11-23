import Core_DesignSystem
import Core_Resources
import SwiftUI

public struct LaunchScreenView: View {
    @ObservedObject private var viewModel: LaunchScreenViewModel

    public init(viewModel: LaunchScreenViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        Asset.Media.logo.swiftUIImage
            .background(.backgroundPrimary)
    }
}
