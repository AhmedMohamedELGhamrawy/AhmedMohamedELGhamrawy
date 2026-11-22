import Foundation
import Capacitor
import UserNotifications

/// iOS version of the Android DhikrReminder plugin.
/// Repeats a local notification ("اللهم صل وسلم على نبينا محمد") with the
/// recorded Arabic voice every `intervalMinutes`, even when the app is closed.
@objc(DhikrReminderPlugin)
public class DhikrReminderPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "DhikrReminderPlugin"
    public let jsName = "DhikrReminder"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "start", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "stop", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "status", returnType: CAPPluginReturnPromise)
    ]

    private let requestId = "com.elghamrawy.myapp.SALAT_ALANABI_REMINDER"
    private let soundName = "salat_alanabi.wav"
    private let enabledKey = "dhikrReminder.enabled"
    private let intervalKey = "dhikrReminder.intervalMinutes"

    @objc func start(_ call: CAPPluginCall) {
        let minutes = max(1, call.getInt("intervalMinutes") ?? 10)
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                call.reject(error.localizedDescription)
                return
            }
            guard granted else {
                call.reject("Notifications permission denied")
                return
            }

            let content = UNMutableNotificationContent()
            content.title = "ربح البيع"
            content.body = "اللهم صل وسلم على نبينا محمد"
            content.sound = self.installSound()
                ? UNNotificationSound(named: UNNotificationSoundName(self.soundName))
                : .default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(minutes * 60), repeats: true)
            let request = UNNotificationRequest(identifier: self.requestId, content: content, trigger: trigger)

            center.removePendingNotificationRequests(withIdentifiers: [self.requestId])
            center.add(request) { error in
                if let error = error {
                    call.reject(error.localizedDescription)
                    return
                }
                UserDefaults.standard.set(true, forKey: self.enabledKey)
                UserDefaults.standard.set(minutes, forKey: self.intervalKey)
                call.resolve(["enabled": true, "intervalMinutes": minutes])
            }
        }
    }

    @objc func stop(_ call: CAPPluginCall) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [requestId])
        center.removeDeliveredNotifications(withIdentifiers: [requestId])
        UserDefaults.standard.set(false, forKey: enabledKey)
        call.resolve(["enabled": false])
    }

    @objc func status(_ call: CAPPluginCall) {
        let saved = UserDefaults.standard.integer(forKey: intervalKey)
        let minutes = saved > 0 ? saved : 10
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            let enabled = requests.contains { $0.identifier == self.requestId }
            call.resolve(["enabled": enabled, "intervalMinutes": minutes])
        }
    }

    /// iOS only plays custom notification sounds from the main bundle or
    /// Library/Sounds, so copy the clip out of this package's bundle once.
    private func installSound() -> Bool {
        let fm = FileManager.default
        guard let library = fm.urls(for: .libraryDirectory, in: .userDomainMask).first,
              let source = Bundle.module.url(forResource: "salat_alanabi", withExtension: "wav") else {
            return false
        }
        let soundsDir = library.appendingPathComponent("Sounds", isDirectory: true)
        let target = soundsDir.appendingPathComponent(soundName)
        if fm.fileExists(atPath: target.path) { return true }
        do {
            try fm.createDirectory(at: soundsDir, withIntermediateDirectories: true)
            try fm.copyItem(at: source, to: target)
            return true
        } catch {
            return false
        }
    }
}
