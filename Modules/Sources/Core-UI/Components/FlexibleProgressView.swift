import Core_DesignSystem
import SwiftUI

public extension FlexibleProgressView {
    struct Style {
        let size: ControlSize
        let tintColor: DS.DynamicColor

        public init(
            size: ControlSize = .large,
            tintColor: DS.DynamicColor = .textPrimary
        ) {
            self.size = size
            self.tintColor = tintColor
        }
    }
}

public struct FlexibleProgressView: View {
    private let style: Style

    public init(style: Style) {
        self.style = style
    }

    public var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color(style.tintColor)))
            .controlSize(style.size)
    }
}

#if DEBUG
struct FlexibleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            previewLarge
            previewSmall
            previewMini
        }
    }

    static var previewLarge: some View {
        FlexibleProgressView(style: .init(size: .large))
    }

    static var previewSmall: some View {
        FlexibleProgressView(style: .init(size: .small))
    }

    static var previewMini: some View {
        FlexibleProgressView(style: .init(size: .mini))
    }
}
#endif
