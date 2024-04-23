import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:haimed_getx/app/mahas/mahas_service.dart';

class EnvironmentConstant {
  static String imageLogo =
      MahasConfig.currentEnv == MahasEnvironmentType.cendana
          ? "assets/images/cendana/logo-nobg.png"
          : MahasConfig.currentEnv == MahasEnvironmentType.premagana
              ? "assets/images/premagana/logo-nobg.png"
              : "assets/images/rsbk/logorsbk.png";

  static String imageSplash =
      MahasConfig.currentEnv == MahasEnvironmentType.cendana
          ? "assets/images/cendana/logo-nobg.png"
          : MahasConfig.currentEnv == MahasEnvironmentType.premagana
              ? "assets/images/premagana/logo-nobg.png"
              : "assets/images/rsbk/loadingrsbktiga.gif";

  static String localNotifImage =
      MahasConfig.currentEnv == MahasEnvironmentType.cendana
          ? "@drawable/cendana/logodua"
          : MahasConfig.currentEnv == MahasEnvironmentType.premagana
              ? "@drawable/premagana/logodua"
              : "@drawable/rsbk/logodua";
}
