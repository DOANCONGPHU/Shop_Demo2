import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_service.dart';

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();


  Future<void> init() async {
    final fcm = FirebaseMessaging.instance;

    NotificationSettings settings = await fcm.requestPermission(
      alert: true, badge: true, sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await fcm.getToken();
      print("FCM Token: $token"); 

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          NotificationService().showNotification(
            id: message.hashCode,
            title: message.notification!.title ?? '',
            body: message.notification!.body ?? '',
          );
        }
      });
    }
  }
}