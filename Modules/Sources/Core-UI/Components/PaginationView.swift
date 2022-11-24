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
    private let loadMore: () -> Void
    private let style: Style

    public init(
        elements: [Element],
        @ViewBuilder rowView: @escaping (Element) -> Content,
        loadMore: @escaping () -> Void,
        style: Style = .init()
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
            loadMore: {}
        )
    }
}
#endif
