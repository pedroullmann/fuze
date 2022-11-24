import Core_DesignSystem
import SwiftUI

public struct FullScreenColor<Content: View>: View {
    private let color: DS.DynamicColor
    private let content: () -> Content

    public init(
        _ color: DS.DynamicColor,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.color = color
        self.content = content
    }

    public var body: some View {
        ZStack {
            Color(color)
                .ignoresSafeArea(.all)

            content()
        }
    }
}

#if DEBUG
struct FullScreenColor_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenColor(.backgroundPrimary) {
            Text("FullScreenColor")
                .textToken(.init(.heading1, .textPrimary))
        }
    }
}
#endif
