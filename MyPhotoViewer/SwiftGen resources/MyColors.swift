// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  typealias Color = UIColor
#endif

// swiftlint:disable file_length

// swiftlint:disable operator_usage_whitespace
extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

// swiftlint:disable identifier_name line_length type_body_length
struct ColorName {
  let rgbaValue: UInt32
  var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e74c3c"></span>
  /// Alpha: 100% <br/> (0xe74c3cff)
  static let alizarin = ColorName(rgbaValue: 0xe74c3cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#9b59b6"></span>
  /// Alpha: 100% <br/> (0x9b59b6ff)
  static let amethyst = ColorName(rgbaValue: 0x9b59b6ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#7f8c8d"></span>
  /// Alpha: 100% <br/> (0x7f8c8dff)
  static let asbestos = ColorName(rgbaValue: 0x7f8c8dff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2980b9"></span>
  /// Alpha: 100% <br/> (0x2980b9ff)
  static let belizeHole = ColorName(rgbaValue: 0x2980b9ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e67e22"></span>
  /// Alpha: 100% <br/> (0xe67e22ff)
  static let carrot = ColorName(rgbaValue: 0xe67e22ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ecf0f1"></span>
  /// Alpha: 100% <br/> (0xecf0f1ff)
  static let clouds = ColorName(rgbaValue: 0xecf0f1ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#95a5a6"></span>
  /// Alpha: 100% <br/> (0x95a5a6ff)
  static let concrete = ColorName(rgbaValue: 0x95a5a6ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2ecc71"></span>
  /// Alpha: 100% <br/> (0x2ecc71ff)
  static let emerald = ColorName(rgbaValue: 0x2ecc71ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#16a085"></span>
  /// Alpha: 100% <br/> (0x16a085ff)
  static let greenSea = ColorName(rgbaValue: 0x16a085ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f27a57"></span>
  /// Alpha: 100% <br/> (0xf27a57ff)
  static let justPeachy = ColorName(rgbaValue: 0xf27a57ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2c3e50"></span>
  /// Alpha: 100% <br/> (0x2c3e50ff)
  static let midnightBlue = ColorName(rgbaValue: 0x2c3e50ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#27ae60"></span>
  /// Alpha: 100% <br/> (0x27ae60ff)
  static let nephritis = ColorName(rgbaValue: 0x27ae60ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f39c12"></span>
  /// Alpha: 100% <br/> (0xf39c12ff)
  static let orange = ColorName(rgbaValue: 0xf39c12ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3498db"></span>
  /// Alpha: 100% <br/> (0x3498dbff)
  static let peterRiver = ColorName(rgbaValue: 0x3498dbff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#c0392b"></span>
  /// Alpha: 100% <br/> (0xc0392bff)
  static let pomegranate = ColorName(rgbaValue: 0xc0392bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d35400"></span>
  /// Alpha: 100% <br/> (0xd35400ff)
  static let pumpkin = ColorName(rgbaValue: 0xd35400ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#bdc3c7"></span>
  /// Alpha: 100% <br/> (0xbdc3c7ff)
  static let silver = ColorName(rgbaValue: 0xbdc3c7ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f1c40f"></span>
  /// Alpha: 100% <br/> (0xf1c40fff)
  static let sunflower = ColorName(rgbaValue: 0xf1c40fff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#1abc9c"></span>
  /// Alpha: 100% <br/> (0x1abc9cff)
  static let turquoise = ColorName(rgbaValue: 0x1abc9cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#34495e"></span>
  /// Alpha: 100% <br/> (0x34495eff)
  static let wetAsphalt = ColorName(rgbaValue: 0x34495eff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#8e44ad"></span>
  /// Alpha: 100% <br/> (0x8e44adff)
  static let wisteria = ColorName(rgbaValue: 0x8e44adff)
}
// swiftlint:enable identifier_name line_length type_body_length

extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
