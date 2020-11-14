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
    internal enum ErrorNetwork {
      internal enum Connection {
        /// When the device has a network again, the app will update automatically 🔌
        internal static let description = L10n.tr("Localizable", "ios-Technical-Test.ErrorNetwork.Connection.description")
        /// Network Error
        internal static let title = L10n.tr("Localizable", "ios-Technical-Test.ErrorNetwork.Connection.title")
      }
      internal enum Generic {
        /// Parece que hemos tenido un problema con los datos de respuesta, vuelve a intentarlo 🙂!
        internal static let description = L10n.tr("Localizable", "ios-Technical-Test.ErrorNetwork.Generic.description")
        /// Oops!
        internal static let title = L10n.tr("Localizable", "ios-Technical-Test.ErrorNetwork.Generic.title")
      }
      internal enum Maintenance {
        /// Estamos en mantenimiento, espere que se recupere el servidor y se le conectara automaticamente 🛠
        internal static let description = L10n.tr("Localizable", "ios-Technical-Test.ErrorNetwork.Maintenance.description")
        /// Maintenance Server
        internal static let title = L10n.tr("Localizable", "ios-Technical-Test.ErrorNetwork.Maintenance.title")
      }
    }
    internal enum ListViewController {
      internal enum Navigation {
        /// MARVEL
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
