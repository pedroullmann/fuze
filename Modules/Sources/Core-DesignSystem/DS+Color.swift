import Root_Extensions
import SwiftUI
import UIKit

// MARK: - Hex Color
public extension Color {
    init(hex: String, fallback: UIColor) {
        let uiColor = UIColor(hex: hex) ?? fallback
        self.init(uiColor)
    }
}

// MARK: - Dynamic (Dark - Light)
public extension DS {
    struct DynamicColor {
        let light: Color
        let dark: Color

        func dynamic(_ scheme: ColorScheme) -> Color {
            scheme == .dark ? dark: light
        }
    }
}

// MARK: - SwiftUI Modifiers
public extension View {
    func foregroundColor(_ ds: DS.DynamicColor) -> some View {
        modifier(ForegroundColorModifier(color: ds))
    }
}

public extension View {
    func accentColor(_ ds: DS.DynamicColor) -> some View {
        modifier(AccentColorModifier(color: ds))
    }
}

public extension View {
    func background(_ ds: DS.DynamicColor) -> some View {
        modifier(BackgroundColorModifier(color: ds))
    }
}

private struct ForegroundColorModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    let color: DS.DynamicColor

    func body(content: Content) -> some View {
        content.foregroundColor(color.dynamic(colorScheme))
    }
}

private struct AccentColorModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    let color: DS.DynamicColor

    func body(content: Content) -> some View {
        content.accentColor(color.dynamic(colorScheme))
    }
}

private struct BackgroundColorModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    let color: DS.DynamicColor

    func body(content: Content) -> some View {
        content.background(color.dynamic(colorScheme))
    }
}
