import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_service.dart';

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

  void demoOnPress() async {
    await authCon.singInWithPassword('demo@demo.com', '123456');
  }

  @override
  void onInit() async {
    demo.value = remoteConfig.getBool('demo');
    super.onInit();
  }
}
