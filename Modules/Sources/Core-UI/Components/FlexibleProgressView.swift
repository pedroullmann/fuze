import Core_DesignSystem
import SwiftUI

public extension FlexibleProgressView {
    struct Style {
        let size: ControlSize

        public init(size: ControlSize = .large) {
            self.size = size
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
            .progressViewStyle(CircularProgressViewStyle(tint: Color(.textPrimary)))
            .controlSize(style.size)
    }
}

#if DEBUG
struct FlexibleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        previewLarge
        previewSmall
        previewMini
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
