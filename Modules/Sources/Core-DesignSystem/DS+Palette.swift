import Foundation

public extension DS.DynamicColor {
    static let textPrimary: Self = .init(dark: .init(hex: "#ffffffff", fallback: .white))
    static let textSecondary: Self = .init(dark: .init(hex: "#ffffff80", fallback: .lightGray))
    static let backgroundPrimary: Self = .init(dark: .init(hex: "#161621ff", fallback: .black))
    static let backgroundSecondary: Self = .init(dark: .init(hex: "#272639ff", fallback: .darkGray))
    static let elementOverSecondary: Self = .init(dark: .init(hex: "#fafafa20", fallback: .darkGray))
    static let dividerPrimary: Self = .init(dark: .init(hex: "#ffffffff", fallback: .white))
    static let staticRed: Self = .init(dark: .init(hex: "#f42a35ff", fallback: .red))
    static let placeholder: Self = .init(dark: .init(hex: "#c4c4c4ff", fallback: .lightGray))
}
