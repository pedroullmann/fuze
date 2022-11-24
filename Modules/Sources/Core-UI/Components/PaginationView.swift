import Core_DesignSystem
import SwiftUI

public struct PaginationStyle {
    public let paddingTop: CGFloat
    public let elementSpacing: CGFloat

    public init(
        paddingTop: CGFloat = DS.Spacing.s,
        elementSpacing: CGFloat = DS.Spacing.m
    ) {
        self.paddingTop = paddingTop
        self.elementSpacing = elementSpacing
    }
}

public struct PaginationView<Element: Identifiable, Content: View>: View {
    private let elements: [Element]
    private let rowView: (Element) -> Content
    private let loadMore: () -> Void
    private let style: PaginationStyle

    public init(
        elements: [Element],
        @ViewBuilder rowView: @escaping (Element) -> Content,
        loadMore: @escaping () -> Void,
        style: PaginationStyle = .init()
    ) {
        self.elements = elements
        self.rowView = rowView
        self.loadMore = loadMore
        self.style = style
    }

    public var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: style.elementSpacing) {
                ForEach(Array(elements.enumerated()), id: \.0) { offset, element in
                    rowView(element)
                }
            }
            .padding(.top, style.paddingTop)
        }
    }
}
