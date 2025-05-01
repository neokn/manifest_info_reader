import Flutter
import UIKit

public class ManifestInfoReaderPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "manifest_info_reader", binaryMessenger: registrar.messenger())
    let instance = ManifestInfoReaderPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getValue":
      guard let arguments = call.arguments as? [String: Any],
            let key = arguments["key"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing or invalid 'key' parameter", details: nil))
        return
      }
      result(getInfoPlistValue(forKey: key))
    case "getInfoPlistValues":
      result(Bundle.main.infoDictionary)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  private func getInfoPlistValue(forKey key: String) -> String? {
    return Bundle.main.infoDictionary?[key] as? String
  }
}
