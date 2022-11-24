import SwiftUI

public extension View {
    func buttonBehavior(isPressed: Bool) -> some View {
        self
            .opacity(isPressed ? 0.85: 1.0)
            .scaleEffect(isPressed ? 0.95: 1.0, anchor: .center)
    }
}
