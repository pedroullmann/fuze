import Core_DesignSystem
import SwiftUI

public extension PaginationView {
    struct Style {
        let paddingTop: CGFloat
        let elementSpacing: CGFloat

        public init(
            paddingTop: CGFloat = DS.Spacing.s,
            elementSpacing: CGFloat = DS.Spacing.m
        ) {
            self.paddingTop = paddingTop
            self.elementSpacing = elementSpacing
        }
    }
}

public struct PaginationView<Element: Identifiable, Content: View>: View {
    private let elements: [Element]
    private let rowView: (Element) -> Content
    private let loadMore: (_ offset: Int) -> Void
    private let style: Style
    private let isLoadingMore: Bool

    public init(
        elements: [Element],
        @ViewBuilder rowView: @escaping (Element) -> Content,
        loadMore: @escaping (_ offset: Int) -> Void,
        style: Style = .init(),
        isLoadingMore: Bool = false
    ) {
        self.elements = elements
        self.rowView = rowView
        self.loadMore = loadMore
        self.style = style
        self.isLoadingMore = isLoadingMore
    }

    public var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: style.elementSpacing) {
                ForEach(Array(elements.enumerated()), id: \.0) { offset, element in
                    rowView(element)
                        .onAppear { loadMore(offset) }
                }

                if isLoadingMore {
                    FlexibleProgressView(style: .init(size: .regular))
                }
            }
            .padding(.top, style.paddingTop)
        }
    }
}

#if DEBUG
struct PaginationView_Previews: PreviewProvider {
    struct MockElement: Equatable, Identifiable {
        var id: String
    }

    static let elements: [MockElement] = [
        .init(id: "Element 1"), .init(id: "Element 2"),
        .init(id: "Element 3"), .init(id: "Element 4"),
        .init(id: "Element 5"), .init(id: "Element 6"),
        .init(id: "Element 7"), .init(id: "Element 8")
    ]

    static var previews: some View {
        PaginationView(
            elements: elements,
            rowView: { Text($0.id) },
            loadMore: { _ in }
        )
    }
}
#endif
