import Foundation

public extension DS.DynamicColor {
    static let textPrimary: Self = .init(
        light: .init(hex: "#ffffffff", fallback: .white),
        dark: .init(hex: "#ffffffff", fallback: .white)
    )

    static let textSecondary: Self = .init(
        light: .init(hex: "#ffffff80", fallback: .lightGray),
        dark: .init(hex: "#ffffff80", fallback: .lightGray)
    )

    static let backgroundPrimary: Self = .init(
        light: .init(hex: "#252525ff", fallback: .black),
        dark: .init(hex: "#252525ff", fallback: .black)
    )

    static let backgroundSecondary: Self = .init(
        light: .init(hex: "#272639ff", fallback: .darkGray),
        dark: .init(hex: "#272639ff", fallback: .darkGray)
    )

    static let elementOverSecondary: Self = .init(
        light: .init(hex: "#fafafa33", fallback: .darkGray),
        dark: .init(hex: "#fafafa33", fallback: .darkGray)
    )

    static let dividerPrimary: Self = .init(
        light: .init(hex: "#ffffffff", fallback: .white),
        dark: .init(hex: "#ffffffff", fallback: .white)
    )
}