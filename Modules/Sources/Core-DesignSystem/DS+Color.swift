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

        public func dynamic(_ scheme: ColorScheme) -> Color {
            scheme == .dark ? dark: light
        }
    }
}
