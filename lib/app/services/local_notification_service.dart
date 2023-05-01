import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();

  void initialize() async {
    var androidInitialization =
        const AndroidInitializationSettings("@drawable/logodua");
    var iOSInitialization = const DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitialization, iOS: iOSInitialization);

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _notificationsPlugin.getNotificationAppLaunchDetails();

    final didNotificationLaunchApp =
        notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
    if (didNotificationLaunchApp) {
      notificationAppLaunchDetails!.notificationResponse!;
    } else {
      _notificationsPlugin.initialize(
        initializationSettings,
      );
    }
  }

  static void showNotificatiOnForeground(RemoteMessage message) {
    const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "com.sanata.haimed.cendana", "haimed",
            importance: Importance.max, priority: Priority.high));
    _notificationsPlugin.show(
        DateTime.now().microsecond,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.notification!.title);
  }

  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
