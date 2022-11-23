// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  /// Try again
  public static let errorAction = Strings.tr("Localizable", "error_action", fallback: "Try again")
  /// Please wait a few minutes
  ///  before you try again
  public static let errorSubtitle = Strings.tr("Localizable", "error_subtitle", fallback: "Please wait a few minutes\n before you try again")
  /// Something went wrong
  public static let errorTitle = Strings.tr("Localizable", "error_title", fallback: "Something went wrong")
  /// EN
  public static let matchListTitle = Strings.tr("Localizable", "match_list_title", fallback: "Matchs")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
