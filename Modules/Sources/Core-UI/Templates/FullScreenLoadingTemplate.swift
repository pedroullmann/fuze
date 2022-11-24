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
            FlexibleProgressView(style: .init())

        case let .loaded(model):
            modelView(model)

        case .error:
            ErrorView(model: .init(action: refreshData))
        }
    }
}
