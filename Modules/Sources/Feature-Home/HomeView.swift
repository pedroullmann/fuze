import Core_DesignSystem
import Core_Resources
import Core_UI
import Root_Elements
import SwiftUI

public struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        FullScreenLoadingTemplate(
            dataState: viewModel.state.dataState,
            modelView: loadedView,
            refreshData: viewModel.fetch
        )
        .localizedNavigationTitle(.matchListTitle)
        .onAppear(perform: viewModel.fetch)
    }

    private func loadedView(_ elements: [MatchModel]) -> some View {
        PaginationView(
            elements: elements,
            rowView: rowView,
            loadMore: viewModel.loadMore,
            isLoadingMore: viewModel.state.isLoadingMore
        )
        .refreshable(action: { viewModel.refresh() })
        .padding(.horizontal, DS.Spacing.m)
    }

    private func rowView(_ element: MatchModel) -> some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(
                cornerRadius: DS.BorderRadius.small,
                style: .continuous
            )
            .foregroundColor(.backgroundSecondary)

            Divider()
                .background(.dividerPrimary)
                .padding(.bottom, DS.Spacing.xm)
        }
        .frame(height: DS.Components.matchCard.height)
        .frame(maxWidth: DS.Components.matchCard.width)
    }
}
