import Core_DesignSystem
import Core_Resources
import SwiftUI

// MARK: - Token
public struct TextToken {
    public let typography: DS.Typography
    public let color: DS.DynamicColor

    public init(
        _ typography: DS.Typography,
        _ color: DS.DynamicColor
    ) {
        self.typography = typography
        self.color = color
    }
}

public extension View {
    func textToken(_ token: TextToken) -> some View {
        modifier(TextTokensModifier(token: token))
    }
}

// MARK: - Modifier
struct TextTokensModifier: ViewModifier {
    private let token: TextToken

    init(token: TextToken) {
        self.token = token
    }

    func body(content: Content) -> some View {
        content
            .foregroundColor(token.color)
            .font(
                .montserrat(
                    .init(rawValue: token.typography.font.name) ?? .regular,
                    fixedSize: token.typography.size
                )
            )
    }
}
