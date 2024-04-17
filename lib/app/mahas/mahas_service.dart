import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haimed_getx/app/models/informasi_umum_model.dart';
import 'package:haimed_getx/app/models/update_app_values_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../firebase_options.dart';
import '../controllers/auth_controller.dart';
import '../models/faq_model.dart';
import '../services/local_notification_service.dart';
import 'mahas_colors.dart';
import 'mahas_config.dart';
import 'models/color_theme_model.dart';

enum MahasEnvironmentType { cendana, rsbk }

final authController = AuthController.instance;
final remoteConfig = FirebaseRemoteConfig.instance;
final auth = FirebaseAuth.instance;

class MahasService {
  // static Future<void> backgroundHandler(RemoteMessage message) async {}

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    //package info
    MahasConfig.packageInfo = await PackageInfo.fromPlatform();
    
    // Environment
    MahasConfig.currentEnv = await currentEnv();

    // transparent status bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    try {
      final Future<FirebaseApp> firebaseInitialization =
          (defaultTargetPlatform == TargetPlatform.android ||
                  defaultTargetPlatform == TargetPlatform.iOS)
              ? Firebase.initializeApp()
              : Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                );

      // auth controller
      await firebaseInitialization.then(
        (value) async {
          // remote config
          await remoteConfig.setConfigSettings(
            RemoteConfigSettings(
              fetchTimeout: const Duration(seconds: 5),
              minimumFetchInterval: Duration.zero,
            ),
          );
          await remoteConfig.fetchAndActivate();
          getRemoteConfig();
          Get.put(AuthController());
        },
      );

      // notif
      // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
      if (!kIsWeb) {
        notification();
      }
    } catch (e) {
      Get.put(AuthController());
    }

    // getstorange
    await GetStorage.init();

    // init notification
    LocalNotificationService().initialize();

    HttpOverrides.global = MyHttpOverrides();
  }

  static Future<MahasEnvironmentType> currentEnv() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (packageInfo.packageName == "com.haimed.rsbk") {
      return MahasEnvironmentType.rsbk;
    } else {
      return MahasEnvironmentType.cendana;
    }
  }

  static void getRemoteConfig() {
    // get api from remote config
    MahasConfig.urlApi = remoteConfig.getString("api");
    MahasConfig.coverImages.add(remoteConfig.getString("cover_images"));
    String faqRemote = remoteConfig.getString("faq");
    if (faqRemote.isNotEmpty) {
      List<dynamic> values = jsonDecode(faqRemote);
      for (var faq in values) {
        MahasConfig.faq.add(FaqModel.fromDynamic(faq));
      }
    }
    String informasiRemote = remoteConfig.getString("informasi_umum");
    if (informasiRemote.isNotEmpty) {
      MahasConfig.informasiUmum = InformasiumumModel.fromJson(informasiRemote);
    }
    String noInternetRemoteConfig =
        remoteConfig.getString("no_internet_error_message");
    if (noInternetRemoteConfig.isNotEmpty) {
      List<dynamic> dataNoInternet = jsonDecode(noInternetRemoteConfig);
      if (dataNoInternet.isNotEmpty) {
        List<String> strlist = dataNoInternet.cast<String>();
        MahasConfig.noInternetErrorMessage.clear();
        MahasConfig.noInternetErrorMessage.addAll(strlist);
      }
    }
    String colorThemeRemoteConfig = remoteConfig.getString("theme_color");
    if (colorThemeRemoteConfig.isNotEmpty) {
      ColorThemeModel colorTheme =
          ColorThemeModel.fromJson(colorThemeRemoteConfig);
      if (colorTheme.primary != null) {
        MahasColors.primary = Color(int.parse(colorTheme.primary!));
      }
      if (colorTheme.danger != null) {
        MahasColors.danger = Color(int.parse(colorTheme.danger!));
      }
      if (colorTheme.warning != null) {
        MahasColors.warning = Color(int.parse(colorTheme.warning!));
      }
    }
    String updateRemote = remoteConfig.getString("update_app_values");
    if (updateRemote.isNotEmpty) {
      MahasConfig.updateAppValues = UpdateappvaluesModel.fromJson(updateRemote);
    }
  }

  //Notif
  static Future<void> notification() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
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
      FirebaseMessaging.instance.getInitialMessage();

      //foreground state
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((message) {
        LocalNotificationService.showNotificatiOnForeground(message);
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
