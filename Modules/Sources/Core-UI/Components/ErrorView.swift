import Core_DesignSystem
import SwiftUI

public extension ErrorView {
    struct Model {
        let action: () -> Void

        public init(action: @escaping () -> Void) {
            self.action = action
        }
    }
}

public struct ErrorView: View {
    private let model: Model

    public init(model: Model) {
        self.model = model
    }

    public var body: some View {
        VStack(spacing: .zero) {
            PrimaryText(.errorTitle)
                .textToken(.init(.heading2, .textPrimary))

            PrimaryText(.errorSubtitle)
                .textToken(.init(.heading3, .textSecondary))
                .multilineTextAlignment(.center)
                .padding(.top, DS.Spacing.xxs)

            Button(
                action: model.action,
                label: { PrimaryText(.errorAction) }
            )
            .buttonStyle(PrimaryButtonStyle())
            .padding(.top, DS.Spacing.m)
        }
    }
}

#if DEBUG
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(model: .init(action: {}))
    }
}
#endif
