import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haimed_getx/app/mahas/mahas_storage.dart';
import 'package:haimed_getx/app/models/informasi_umum_model.dart';
import 'package:haimed_getx/app/models/update_app_values_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../firebase_options.dart';
import '../controllers/auth_controller.dart';
import '../models/artikel_firebase_model.dart';
import '../models/faq_model.dart';
import '../modules/splash_screen/controllers/splash_screen_controller.dart';
import '../services/local_notification_service.dart';
import 'mahas_colors.dart';
import 'mahas_config.dart';
import 'models/color_theme_model.dart';

enum MahasEnvironmentType { cendana, rsbk }

final authController = AuthController.instance;
final remoteConfig = FirebaseRemoteConfig.instance;
final auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final splashController = SplashScreenController.instance;

class MahasService {
  // static Future<void> backgroundHandler(RemoteMessage message) async {}

  static Future<void> init() async {
    // getstorange
    await GetStorage.init();

    //package info
    MahasConfig.packageInfo = await PackageInfo.fromPlatform();

    // transparent status bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    //init firebase
    await checkFirebase(isInit: true);

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

  static Future<void> checkFirebase({bool isInit = false}) async {
    try {
      final Future<FirebaseApp> firebaseInitialization =
          (defaultTargetPlatform == TargetPlatform.android ||
                  defaultTargetPlatform == TargetPlatform.iOS)
              ? Firebase.initializeApp()
              : Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                );
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
          if (isInit) Get.put(AuthController());
          splashController.isError.value = false;
        },
      );
      if (!kIsWeb) {
        notification();
      }
    } catch (e) {
      splashController.isError.value = true;
    }
  }

  static void getRemoteConfig() {
    // get api from remote config
    MahasConfig.urlApi = remoteConfig.getString("api");
    dynamic covers = MahasStorage.getCoverImages();
    if (covers != null) {
      for (var value in covers) {
        MahasConfig.coverImages.add(value);
      }
    } else {
      String images = remoteConfig.getString("cover_images");
      if (images.isNotEmpty) {
        List<dynamic> values = jsonDecode(images);
        for (var value in values) {
          MahasConfig.coverImages.add(value);
        }
        MahasStorage.setCoverImages(MahasConfig.coverImages);
      }
    }

    List<FaqModel>? faqs = MahasStorage.getFaq();
    if (faqs != null) {
      MahasConfig.faq.addAll(faqs);
    } else {
      String faqRemote = remoteConfig.getString("faq");
      if (faqRemote.isNotEmpty) {
        List<dynamic> values = jsonDecode(faqRemote);
        for (var faq in values) {
          MahasConfig.faq.add(FaqModel.fromDynamic(faq));
        }
        MahasStorage.setFaq(MahasConfig.faq);
      }
    }

    InformasiumumModel? informasiumumModel = MahasStorage.getInformasiUmum();
    if (informasiumumModel != null) {
      MahasConfig.informasiUmum = informasiumumModel;
    } else {
      String informasiRemote = remoteConfig.getString("informasi_umum");
      if (informasiRemote.isNotEmpty) {
        MahasConfig.informasiUmum =
            InformasiumumModel.fromJson(informasiRemote);
        MahasStorage.setInformasiUmum(MahasConfig.informasiUmum);
      }
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

    ColorThemeModel? colorThemeModel = MahasStorage.getColorTheme();
    if (colorThemeModel != null) {
      if (colorThemeModel.primary != null) {
        MahasColors.primary = Color(int.parse(colorThemeModel.primary!));
      }
      if (colorThemeModel.danger != null) {
        MahasColors.danger = Color(int.parse(colorThemeModel.danger!));
      }
      if (colorThemeModel.warning != null) {
        MahasColors.warning = Color(int.parse(colorThemeModel.warning!));
      }
    } else {
      String colorThemeRemoteConfig = remoteConfig.getString("theme_color");
      if (colorThemeRemoteConfig.isNotEmpty) {
        ColorThemeModel colorTheme =
            ColorThemeModel.fromJson(colorThemeRemoteConfig);
        MahasStorage.setColorTheme(colorTheme);
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
    }

    String updateRemote = remoteConfig.getString("update_app_values");
    if (updateRemote.isNotEmpty) {
      MahasConfig.updateAppValues = UpdateappvaluesModel.fromJson(updateRemote);
    }
  }

  //firestore
  Future<List<ArtikelFirestoreModel>> getListArtikelFirestore() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("faskes")
        .doc(MahasConfig.informasiUmum.faskesKeyID)
        .collection("artikel")
        .orderBy('tanggal', descending: true)
        .get();

    return querySnapshot.docs
        .map((e) => ArtikelFirestoreModel.fromSnapshot(e))
        .toList();
  }

  static bool isInternetCausedError(String error) {
    bool result = true;
    for (var e in MahasConfig.noInternetErrorMessage) {
      if (error.contains(RegExp(e, caseSensitive: false))) {
        result = true;
        break;
      } else {
        result = false;
      }
    }
    return result;
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
