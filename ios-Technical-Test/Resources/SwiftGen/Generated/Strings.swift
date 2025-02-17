// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Shared {
    /// Aceptar
    internal static let accept = L10n.tr("Localizable", "Shared.accept")
    /// 
    internal static let empty = L10n.tr("Localizable", "Shared.empty")
  }

  internal enum IosTechnicalTest {
    internal enum ListViewController {
      internal enum Navigation {
        /// ElectroMaps
        internal static let title = L10n.tr("Localizable", "ios-Technical-Test.ListViewController.navigation.title")
      }
      internal enum Searching {
        /// You haven't found what you were looking for, man!\n\nBad luck!
        internal static let resulNotFound = L10n.tr("Localizable", "ios-Technical-Test.ListViewController.searching.resulNotFound")
        /// Estamos descargando la lista\n\n¿Estas preparado para frikear ?
        internal static let title = L10n.tr("Localizable", "ios-Technical-Test.ListViewController.searching.title")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
