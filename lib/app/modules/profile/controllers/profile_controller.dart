import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../mahas/mahas_service.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  RxString profilePic = ''.obs;

  @override
  void onInit() {
    profilePic.value = auth.currentUser?.photoURL ?? "";
    super.onInit();
  }

  void popupMenuButtonOnSelected(String v) async {
    if (v == 'edit') {
      toEditProfile();
    } else if (v == 'keluar') {
      toLogout();
    }
  }

  void toPasien() {
    Get.toNamed(Routes.PASIEN);
  }

  void toDokter() {
    Get.toNamed(Routes.DOKTER_FAVORITE);
  }

  void toEditProfile() {
    Get.toNamed(Routes.PROFILE_SETUP);
  }

  void toLogout() async {
    var authCon = Get.put(AuthController());
    await authCon.signOut();
  }
}
