import 'package:haimed_getx/app/mahas/mahas_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../models/faq_model.dart';
import '../models/informasi_umum_model.dart';
import '../models/profile_model.dart';
import '../models/update_app_values_model.dart';

class MahasConfig {
  static PackageInfo? packageInfo;
  static MahasEnvironmentType currentEnv = MahasEnvironmentType.cendana;
  static ProfileModel? profile;
  static String urlApi = '';
  static List<String> coverImages = [];
  static List<FaqModel> faq = [];
  static InformasiumumModel informasiUmum = InformasiumumModel();
  static UpdateappvaluesModel updateAppValues = UpdateappvaluesModel();
  // static String urlApi = 'https://apps.sanatasystem.net/HaimedSanataDev';
  static bool isLaravelBackend = false;
  static List<String> noInternetErrorMessage = [
    'A network error',
    'failed host lookup',
    'user was not linked',
    'unexpected end of stream',
    'network_error',
  ];
}
