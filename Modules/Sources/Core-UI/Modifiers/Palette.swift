import Core_DesignSystem
import SwiftUI

public extension SwiftUI.Color {
    init(_ ds: DS.DynamicColor) {
        self = ds.dark
    }
}

public extension View {
    func foregroundColor(_ ds: DS.DynamicColor) -> some View {
        self.foregroundColor(ds.dark)
    }
}

public extension View {
    func accentColor(_ ds: DS.DynamicColor) -> some View {
        self.accentColor(ds.dark)
    }
}

public extension View {
    func background(_ ds: DS.DynamicColor) -> some View {
        self.background(ds.dark)
    }
}
