import Root_Extensions
import SwiftUI
import UIKit

public extension Color {
    init(hex: String, fallback: UIColor) {
        let uiColor = UIColor(hex: hex) ?? fallback
        self.init(uiColor)
    }
}

public extension DS {
    struct DynamicColor {
        let light: Color
        let dark: Color

        public func dynamic(_ scheme: ColorScheme) -> Color {
            scheme == .dark ? dark: light
        }
    }
}
