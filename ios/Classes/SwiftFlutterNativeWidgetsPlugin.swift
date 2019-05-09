import Flutter
import UIKit

public class SwiftFlutterNativeWidgetsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_native_widgets", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterNativeWidgetsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "getPlatformVersion") {
        result("iOS " + UIDevice.current.systemVersion)
    }else if (call.method == "showConfirmDialog") {
        showConfirmDialog(call:call,result:result)
    } else {
        result("notImplemented")
    }
    
  }
    
  private func showConfirmDialog(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let alertData = AlertData(withDictionary: call.arguments as! Dictionary<String, Any>)
        let alertController = buildConfirmDialog(alertData: alertData, result: result)

        if let topController = getTopViewController() {
            topController.present(alertController, animated: true)
        } else {
            result(FlutterError(code: "no_view_controller", message: "No ViewController available to present a dialog", details: nil))
        }

    }
    
    private func buildConfirmDialog(alertData: AlertData, result: @escaping FlutterResult) -> UIAlertController {
        let alertController = buildAlertController(title: alertData.title, message: alertData.message)
        alertController.addAction(UIAlertAction(title: alertData.positiveButtonText, style: alertData.destructive ? .destructive : .default, handler: { _ in
            result(true)
        }))
        alertController.addAction(UIAlertAction(title: alertData.negativeButtonText, style: .cancel, handler: { _ in
            result(false)
        }))
        return alertController
    }
    
    private func buildAlertController(title: String?, message: String?) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    }
    
    private func getTopViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        
        return nil
    }

}
