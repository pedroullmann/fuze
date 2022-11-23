import CoreGraphics
import Foundation
import SwiftUI

// MARK: - Registarable Protocol
public protocol Registarable {
    func registerFont(
        fontName: String,
        fontExtension: String,
        failureHandler: @escaping (String) -> Void
    )

    func registerFonts(
        fonts: [Font.MontserratStyle],
        failureHandler: @escaping (String) -> Void
    )
}

public struct Resources: Registarable {
    private let bundle: Bundle

    public init(bundle: Bundle = Self.bundle) {
        self.bundle = bundle
    }

    public func registerFont(
        fontName: String,
        fontExtension: String = "ttf",
        failureHandler: @escaping (String) -> Void
    ) {
        guard
            let url = bundle.url(forResource: fontName, withExtension: fontExtension),
            let provider = CGDataProvider(url: url as CFURL),
            let font = CGFont(provider)
        else {
            failureHandler("Couldn't create font from filename: \(fontName)")
            return
        }

        var error: Unmanaged<CFError>?
        if CTFontManagerRegisterGraphicsFont(font, &error) == false {
            failureHandler("Couldn't load font: \(fontName)")
        }
    }

    public func registerFonts(
        fonts: [Font.MontserratStyle],
        failureHandler: @escaping (String) -> Void
    ) {
        fonts.forEach {
            registerFont(
                fontName: $0.rawValue,
                failureHandler: failureHandler
            )
        }
    }
}

// MARK: - Bundle
public extension Resources {
    static let bundle = Bundle.module
}

#if DEBUG
public final class ResourcesSpy: Registarable {
    public var registerFontsWasCalled: Bool
    public var registerFontWasCalled: Bool
    public init(
        registerFontsWasCalled: Bool = false,
        registerFontWasCalled: Bool = false
    ) {
        self.registerFontsWasCalled = registerFontsWasCalled
        self.registerFontWasCalled = registerFontWasCalled
    }

    public func registerFont(fontName: String, fontExtension: String, failureHandler: @escaping (String) -> Void) {
        registerFontWasCalled = true
    }
    public func registerFonts(fonts: [Font.MontserratStyle], failureHandler: @escaping (String) -> Void) {
        registerFontsWasCalled = true
    }
}

public struct ResourcesDummy: Registarable {
    public init() {}
    public func registerFont(fontName: String, fontExtension: String, failureHandler: @escaping (String) -> Void) {}
    public func registerFonts(fonts: [Font.MontserratStyle], failureHandler: @escaping (String) -> Void) {}
}
#endif
