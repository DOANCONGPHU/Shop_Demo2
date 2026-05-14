import UIKit
import Flutter
import flutter_local_notifications
import GoogleMaps
import flutter_foreground_task

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    guard let apiKey = Bundle.main.object(
      forInfoDictionaryKey: "STADIA_API_KEY"
    ) as? String else {
      fatalError("STADIA_API_KEY không có trong Info.plist")
    }

    GMSServices.provideAPIKey(apiKey)
    
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    GeneratedPluginRegistrant.register(with: self)
    
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }
    
    SwiftFlutterForegroundTaskPlugin.setPluginRegistrantCallback { registry in
      GeneratedPluginRegistrant.register(with: registry)
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.alert, .badge, .sound])
  }
}