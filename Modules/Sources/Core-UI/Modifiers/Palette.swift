import Core_DesignSystem
import SwiftUI

public extension SwiftUI.Color {
    private static let colorProvider = DynamicColorProvider()

    init(_ ds: DS.DynamicColor) {
        self = Self.colorProvider.getColor(ds)
    }
}

private struct DynamicColorProvider: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        EmptyView()
    }

    func getColor(_ ds: DS.DynamicColor) -> Color {
        ds.dynamic(colorScheme)
    }
}

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
