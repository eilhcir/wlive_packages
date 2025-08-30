import Flutter
import UIKit
import Photos

public class SwiftLecleFlutterAbsolutePathPlugin: NSObject, FlutterPlugin, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var flutterResult : FlutterResult!
    var error: NSError?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "lecle_flutter_absolute_path", binaryMessenger: registrar.messenger())
        let instance = SwiftLecleFlutterAbsolutePathPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.flutterResult = result
        
        if (call.method == "getAbsolutePath") {
            guard let args = call.arguments as? [String : Any?] else { return }
            
            guard let uri = args["uri"] as? String else {
                result(FlutterError(code: "Assertion_Error", message: "Uri is required!", details: nil))
                return
            }
            
            getFileAbsolutePath(uri: uri)
        }
    }
    
    func getFileAbsolutePath(uri: String) {
        if (uri.starts(with: "file://") || uri.starts(with: "/var/mobile/Media") || uri.starts(with: "/private/var/mobile")) {
            self.flutterResult(uri.replacingOccurrences(of: "file://", with: ""))
            return
        }
        let phAsset = PHAsset.fetchAssets(withLocalIdentifiers: [uri], options: .none).firstObject
        if(phAsset == nil) {
            self.flutterResult(nil)
            return
        }
        let editingOptions = PHContentEditingInputRequestOptions()
        editingOptions.isNetworkAccessAllowed = true
        phAsset!.requestContentEditingInput(with: editingOptions) { (input, _) in
            let url = input?.fullSizeImageURL?.absoluteString.replacingOccurrences(of: "file://", with: "")
            self.flutterResult(url)
        }
    }
}
