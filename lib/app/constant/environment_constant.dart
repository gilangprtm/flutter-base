import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:haimed_getx/app/mahas/mahas_service.dart';

class EnvironmentConstant {
  static String imageLogo = "";
  static String imageSplash = "";
  static String localNotifImage = "";

  void environment() {
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
}
