import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../firebase_options.dart';
import '../controllers/auth_controller.dart';
import '../services/local_notification_service.dart';
import 'mahas_colors.dart';
import 'mahas_config.dart';

final authController = AuthController.instance;
final remoteConfig = FirebaseRemoteConfig.instance;
final auth = FirebaseAuth.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

class MahasService {
  static PackageInfo? packageInfo;
  static Future<void> backgroundHandler(RemoteMessage message) async {}

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // transparent status bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    // auth controller
    await firebaseInitialization.then((value) {
      Get.put(AuthController());
    });

    // notif
    // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    // if (!kIsWeb) {
    //   if (Platform.isAndroid || Platform.isIOS) {
    //     if (Platform.isAndroid) {
    //       androidNotification();
    //     } else {
    //       appleNotification();
    //     }
    //   }
    // }

    // packageInfo
    packageInfo = await PackageInfo.fromPlatform();

    // remote config
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(hours: 1),
        minimumFetchInterval: const Duration(minutes: 2),
      ),
    );
    await remoteConfig.fetchAndActivate();
    if (MahasConfig.urlApi.isEmpty) {
      MahasConfig.urlApi = remoteConfig.getString('api');
    }

    // getstorange
    await GetStorage.init();

    // init notification
    LocalNotificationService().initialize();

    HttpOverrides.global = MyHttpOverrides();
  }

  //Notif Android
  static Future<void> androidNotification() async {
    //terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {});

    //foreground state
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.showNotificatiOnForeground(message);
    });

    //notif jadwal
    // FirebaseMessaging.onMessage.listen((message) {
    //   LocalNotificationService.showNotifJadwal(message);
    // });

    //background state
    FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  }

  //Notif Apple
  static Future<void> appleNotification() async {
    late final FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // For handling the received notifications
      //terminated state
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        //   showSimpleNotification(
        //     Text("${message?.notification!.title}"),
        //     subtitle: Text("${message?.notification!.body}"),
        //     background: MahasColors.lightBlue,
        //     duration: const Duration(seconds: 3),
        //  );
      });

      //foreground state
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((message) {
        // LocalNotificationService.showNotificatiOnForeground(message);
        showSimpleNotification(
          Text("${message.notification!.title}"),
          subtitle: Text("${message.notification!.body}"),
          background: MahasColors.primary,
          duration: const Duration(seconds: 3),
        );
      });

      //background state
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        // showSimpleNotification(
        //   Text("${message.notification!.title}"),
        //   subtitle: Text("${message.notification!.body}"),
        //   background: MahasColors.lightBlue,
        //   duration: const Duration(seconds: 3),
        // );
      });
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
