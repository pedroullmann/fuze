import Core_DesignSystem
import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        configuration.label
            .textToken(.init(.paragraph1Bold, .textPrimary))
            .frame(
                width: DS.Components.primaryButton.width,
                height: DS.Components.primaryButton.height
            )
            .background(
                RoundedRectangle(
                    cornerRadius: DS.BorderRadius.small,
                    style: .continuous
                )
                .foregroundColor(.staticRed)
            )
            .buttonBehavior(isPressed: configuration.isPressed)
    }
}
