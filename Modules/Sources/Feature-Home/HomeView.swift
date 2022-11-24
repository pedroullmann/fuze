import Core_DesignSystem
import Core_Resources
import Core_UI
import Root_Elements
import SwiftUI

// TODO: Remove
private struct MockIdentifiable: Equatable, Identifiable {
    public var id: String = UUID().uuidString
}

public struct HomeView: View {
    // TODO: Remove
    private var mock: DataState<[MockIdentifiable]> = .error

    public init() {}

    public var body: some View {
        FullScreenLoadingTemplate(
            dataState: mock,
            modelView: loadedView,
            refreshData: { /* Refresh */ }
        )
        .localizedNavigationTitle(.matchListTitle)
    }

    private func loadedView(_ model: [MockIdentifiable]) -> some View {
        PaginationView(
            elements: model,
            rowView: rowView,
            loadMore: { /* Load more */ }
        )
        .padding(.horizontal, DS.Spacing.m)
    }

    // TODO: Card View
    private func rowView(_ model: MockIdentifiable) -> some View {
        EmptyView()
    }
}
