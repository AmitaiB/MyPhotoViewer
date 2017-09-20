// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable file_length

// swiftlint:disable identifier_name line_length type_body_length
enum L10n {
  /// PhotoCellReuseID
  static let photoCellReuseID = L10n.tr("localizable", "PhotoCellReuseID")
  /// http://jsonplaceholder.typicode.com/photos
  static let httpJsonplaceholderTypicodeComPhotos = L10n.tr("localizable", "http://jsonplaceholder.typicode.com/photos")
}
// swiftlint:enable identifier_name line_length type_body_length

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
