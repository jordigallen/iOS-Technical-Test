// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e0e0e0"></span>
  /// Alpha: 100% <br/> (0xe0e0e0ff)
  internal static let lightGray = ColorName(rgbaValue: 0xe0e0e0ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fafafa"></span>
  /// Alpha: 100% <br/> (0xfafafaff)
  internal static let lightGrayColor = ColorName(rgbaValue: 0xfafafaff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#bdbdbd"></span>
  /// Alpha: 100% <br/> (0xbdbdbdff)
  internal static let mediumGray = ColorName(rgbaValue: 0xbdbdbdff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff014d"></span>
  /// Alpha: 100% <br/> (0xff014dff)
  internal static let redColor = ColorName(rgbaValue: 0xff014dff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#9e9e9e"></span>
  /// Alpha: 100% <br/> (0x9e9e9eff)
  internal static let strongGray = ColorName(rgbaValue: 0x9e9e9eff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let whiteColor = ColorName(rgbaValue: 0xffffffff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
