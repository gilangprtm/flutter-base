import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum MahasEnvironmentType {
  cendana,
  rsbk,
  rsbkdev,
  premagana,
  suwiti,
  giriasih
}

class EnvironmentConstant {
  static String imageLogo = "";
  static String imageSplash = "";
  static String localNotifImage = "";

  static void environment() {
    if (MahasConfig.currentEnv == MahasEnvironmentType.cendana) {
      imageLogo = "assets/images/cendana/logo-nobg.png";
      imageSplash = "assets/images/cendana/logo-nobg.png";
      localNotifImage = "@drawable/logonotifcendana";
    } else if (MahasConfig.currentEnv == MahasEnvironmentType.premagana) {
      imageLogo = "assets/images/premagana/logo-nobg.png";
      imageSplash = "assets/images/premagana/logo-nobg.png";
      localNotifImage = "@drawable/logonotifpremagana";
    } else if (MahasConfig.currentEnv == MahasEnvironmentType.rsbk) {
      imageLogo = "assets/images/rsbk/logorsbk.png";
      imageSplash = "assets/images/rsbk/loadingrsbktiga.gif";
      localNotifImage = "@drawable/logonotifbhayangkara";
    } else if (MahasConfig.currentEnv == MahasEnvironmentType.rsbkdev) {
      imageLogo = "assets/images/rsbk/logorsbk.png";
      imageSplash = "assets/images/rsbk/loadingrsbktiga.gif";
      localNotifImage = "@drawable/logonotifbhayangkara";
    } else if (MahasConfig.currentEnv == MahasEnvironmentType.suwiti) {
      imageLogo = "assets/images/suwiti/logo-nobg.png";
      imageSplash = "assets/images/suwiti/logo-nobg.png";
      localNotifImage = "@drawable/logonotifsuwiti";
    } else if (MahasConfig.currentEnv == MahasEnvironmentType.giriasih) {
      imageLogo = "assets/images/giriasih/logo-nobg.png";
      imageSplash = "assets/images/giriasih/logo-nobg.png";
      localNotifImage = "@drawable/logonotifgiriasih";
    }
  }

  static Future<MahasEnvironmentType> currentEnv() async {
    final packageInfo = await PackageInfo.fromPlatform();

    if (packageInfo.packageName == "com.haimed.rsbk") {
      return MahasEnvironmentType.rsbk;
    } else if (packageInfo.packageName == "com.sanata.haimed.rsbk.dev") {
      return MahasEnvironmentType.rsbkdev;
    } else if (packageInfo.packageName == "com.sanata.haimed.premagana") {
      return MahasEnvironmentType.premagana;
    } else if (packageInfo.packageName == "com.sanata.haimed.rssuwiti") {
      return MahasEnvironmentType.suwiti;
    } else if (packageInfo.packageName == "com.sanata.haimed.rsgiriasih") {
      return MahasEnvironmentType.giriasih;
    } else {
      return MahasEnvironmentType.cendana;
    }
  }
}
