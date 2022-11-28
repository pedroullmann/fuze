import Core_DesignSystem
import Core_Resources
import Core_UI
import Feature_Home_Repository
import Feature_MatchDetails
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
        .onAppear(perform: viewModel.onAppear.send)
    }

    private func loadedView(_ elements: [MatchModel]) -> some View {
        PaginationView(
            elements: elements,
            rowView: rowView,
            loadMore: viewModel.loadMore,
            isLoadingMore: viewModel.state.isLoadingMore
        )
        .padding(.horizontal, DS.Spacing.m)
        .overlay(
            NavigationLink(
                destination: viewModel.state.selectedMatch.map {
                    MatchDetailsView(
                        match: $0,
                        viewModel: .init(
                            environment: .init(
                                service: viewModel.environment.matchDetailsService,
                                scheduler: viewModel.environment.scheduler
                            )
                        )
                    )
                },
                isActive: viewModel.isNavigationActive,
                label: EmptyView().hidden
            )
        )
    }

    private func rowView(_ element: MatchModel) -> some View {
        Button(
            action: { viewModel.navigateToDetail(element) },
            label: { MatchRowView(match: element) }
        )
    }
}
