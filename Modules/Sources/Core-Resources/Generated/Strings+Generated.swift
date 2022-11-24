// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

// MARK: - Strings

public extension LocalizedString {
  /// Try again
  static let errorAction: Self = .init(lookupKey: "error_action")
  /// Please wait a few minutes\n before you try again
  static let errorSubtitle: Self = .init(lookupKey: "error_subtitle")
  /// Something went wrong
  static let errorTitle: Self = .init(lookupKey: "error_title")
  /// Matchs
  static let matchListTitle: Self = .init(lookupKey: "match_list_title")
}

// MARK: - Implementation Details

extension LocalizedString {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

public struct LocalizedString {
  public let lookupKey: String

  public var key: LocalizedStringKey {
    LocalizedStringKey(lookupKey)
  }

  public var text: String {
    Self.tr("Localizable", lookupKey)
  }
}

private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
      return Bundle.module
    #else
      return Bundle(for: BundleToken.self)
    #endif
  }()
}
