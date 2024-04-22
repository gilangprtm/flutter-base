import 'package:get/get.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';

import '../../../controllers/auth_controller.dart';

class LoginController extends GetxController {
  var authCon = Get.put(AuthController());
  var demo = false.obs;

  void toLogin() {
    Get.toNamed(Routes.REGISTER);
  }

  void googleLoginOnPress() async {
    await authCon.signInWithGoogle();
  }

  void appleLoginOnPress() async {
    await authCon.signInWithApple();
  }
}
