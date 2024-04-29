import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';

class LoginController extends GetxController {
  var authCon = AuthController.instance;
  var demo = false.obs;
  void googleLoginOnPress() async {
    await authCon.signInWithGoogle();
  }

  void appleLoginOnPress() async {
    await authCon.signInWithApple();
  }
}
