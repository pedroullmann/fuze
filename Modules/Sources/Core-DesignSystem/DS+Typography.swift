import Core_Resources
import Foundation

public extension DS {
    struct Typography {
        public struct Font {
            public let family: String
            public let style: String

            public var name: String {
                "\(family)-\(style)"
            }
        }

        public let font: Font
        public let size: CGFloat
    }
}

// MARK: - Tokens
public extension DS.Typography {
    static let heading1: Self = .init(
        font: .init(
            family: "Montserrat",
            style: "Regular"
        ),
        size: 32
    )

    static let heading2: Self = .init(
        font: .init(
            family: "Montserrat",
            style: "Regular"
        ),
        size: 18
    )

    static let paragraph1: Self = .init(
        font: .init(
            family: "Montserrat",
            style: "Regular"
        ),
        size: 14
    )

    static let paragraph1Bold: Self = .init(
        font: .init(
            family: "Montserrat",
            style: "Bold"
        ),
        size: 14
    )

    static let paragraph2: Self = .init(
        font: .init(
            family: "Montserrat",
            style: "Regular"
        ),
        size: 12
    )

    static let paragraph2Bold: Self = .init(
        font: .init(
            family: "Montserrat",
            style: "Bold"
        ),
        size: 12
    )

    static let paragraph3: Self = .init(
        font: .init(
            family: "Montserrat",
            style: "Regular"
        ),
        size: 10
    )

    static let paragraph4: Self = .init(
        font: .init(
            family: "Montserrat",
            style: "Regular"
        ),
        size: 8
    )
}
