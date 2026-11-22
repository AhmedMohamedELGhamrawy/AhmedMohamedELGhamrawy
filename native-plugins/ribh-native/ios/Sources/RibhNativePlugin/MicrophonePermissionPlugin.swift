import Foundation
import Capacitor
import AVFoundation

/// iOS version of the Android MicrophonePermission plugin.
@objc(MicrophonePermissionPlugin)
public class MicrophonePermissionPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "MicrophonePermissionPlugin"
    public let jsName = "MicrophonePermission"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "request", returnType: CAPPluginReturnPromise)
    ]

    @objc func request(_ call: CAPPluginCall) {
        let done: (Bool) -> Void = { granted in call.resolve(["granted": granted]) }
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission(completionHandler: done)
        } else {
            AVAudioSession.sharedInstance().requestRecordPermission(done)
        }
    }
}
