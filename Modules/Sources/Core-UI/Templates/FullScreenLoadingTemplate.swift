import Core_DesignSystem
import Core_Resources
import Root_Elements
import SwiftUI

public struct FullScreenLoadingTemplate<Model: Equatable, Content: View>: View {
    private let dataState: DataState<Model>
    private let modelView: (Model) -> Content
    private let refreshData: () -> Void

    public init(
        dataState: DataState<Model>,
        @ViewBuilder modelView: @escaping (Model) -> Content,
        refreshData: @escaping () -> Void
    ) {
        self.dataState = dataState
        self.modelView = modelView
        self.refreshData = refreshData
    }

    public var body: some View {
        switch dataState {
        case .loading:
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color(.textPrimary)))
                .controlSize(.large)

        case let .loaded(model):
            modelView(model)

        case .error:
            VStack(spacing: .zero) {
                Text(Strings.errorTitle)
                    .textToken(.init(.heading2, .textPrimary))

                Text(Strings.errorSubtitle)
                    .textToken(.init(.heading3, .textSecondary))
                    .multilineTextAlignment(.center)
                    .padding(.top, DS.Spacing.xxs)

                Button(
                    action: refreshData,
                    label: { Text(Strings.errorAction) }
                )
                .buttonStyle(PrimaryButtonStyle())
                .padding(.top, DS.Spacing.m)
            }
        }
    }
}
