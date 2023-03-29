import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  void toPasien() {
    Get.toNamed(Routes.PASIEN);
  }

  void toDokter() {
    Get.toNamed(Routes.DOKTER_FAVORITE);
  }
}
