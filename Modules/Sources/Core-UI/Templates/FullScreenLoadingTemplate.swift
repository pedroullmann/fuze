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

#if DEBUG
struct FullScreenLoadingTemplate_Previews: PreviewProvider {
    typealias State = DataState<String>

    static var previews: some View {
        Group {
            previewLoading
            previewLoaded
            previewError
        }
    }

    static var previewLoading: some View {
        let state: State = .loading
        return FullScreenColor(.backgroundPrimary) {
            FullScreenLoadingTemplate(
                dataState: state,
                modelView: { _ in EmptyView() },
                refreshData: {}
            )
        }
    }

    static var previewLoaded: some View {
        let state: State = .loaded("Loaded")
        return FullScreenColor(.backgroundPrimary) {
            FullScreenLoadingTemplate(
                dataState: state,
                modelView: {
                    Text($0)
                        .textToken(.init(.heading1, .textPrimary))
                },
                refreshData: {}
            )
        }
    }

    static var previewError: some View {
        let state: State = .error
        return FullScreenColor(.backgroundPrimary) {
            FullScreenLoadingTemplate(
                dataState: state,
                modelView: { _ in EmptyView() },
                refreshData: {}
            )
        }
    }
}
#endif
